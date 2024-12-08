import 'dart:collection';

import 'dart:developer' as dev;

import 'package:flutter/widgets.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/services/services.dart';
import 'package:foods_app/widgets/widgets.dart';

import 'package:watch_it/watch_it.dart';

class FoodHistoryManager extends ChangeNotifier {
  final _foodsHistory = Queue<Food?>();
  Food? get currentFood => _foodsHistory.last;
  List<Food?> get foodsHistory => _foodsHistory.toList();

  void addFoodToHistory(Food food) {
    _foodsHistory.addLast(food);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _foodsHistory.clear();
    notifyListeners();
  }
}

class FoodDetailManager extends ChangeNotifier {
  Map<int, AmountRecord> _amountStrings = {};
  Food? _currentFood;

  Food? get currentFood => _currentFood;

  Map<int, AmountRecord> get amountStrings => _amountStrings;

  static const circularRangeFinderPercentChange = .05;

  Future<void> queryFood(int id) async {
    Food? food;
    try {
      final foodsDB =
          di.get<FoodsDB>(instanceName: LocatorInstanceNames.foodsDBService);

      final foodDTO = await foodsDB.queryFood(id: id);
      food = Food.fromFoodDTO(foodDTO!);

      _amountStrings = await food.createAmountStrings();
    } catch (e) {
      dev.log(
        'queryFood throws',
        name: 'FoodDetailManager - queryFood',
        time: DateTime.now(),
        error: e,
      );
    } finally {
      _currentFood = food;
      notifyListeners();
    }
  }

  void changeUnits(RotationDirection direction) {
    final newMap = <int, AmountRecord>{};
    for (final en in _amountStrings.entries) {
      final key = en.key;
      final oldValue = en.value.$1;
      final unit = en.value.$3;

      final newValue = direction == RotationDirection.clockwise
          ? oldValue * (1 + (circularRangeFinderPercentChange / 100))
          : oldValue * (1 - (circularRangeFinderPercentChange / 100));

      newMap[key] = (newValue, Food.convertAmountToString(newValue), unit);
    }
    _amountStrings = newMap;
    notifyListeners();
  }

  Future<void> resetToOriginalAmounts() async {
    final amounts = await _currentFood!.createAmountStrings();
    _amountStrings = amounts;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();

    notifyListeners();
  }
}
