import 'dart:collection';
// ignore: unused_import
import 'dart:developer' as dev;

import 'package:flutter/widgets.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/services/services.dart';
import 'package:foods_app/widgets/widgets.dart';

import 'package:watch_it/watch_it.dart';

class FoodHistoryManager {
  final _foodsHistory = Queue<Food?>();
  Food? get currentFood => _foodsHistory.last;
  List<Food?> get foodsHistory => _foodsHistory.toList();

  void addFoodToHistory(Food food) => _foodsHistory.addLast(food);

  void clearFoods() => _foodsHistory.clear();
}

class FoodDetailManager extends ChangeNotifier {
  final currentFood = ValueNotifier<Food?>(null);
  Map<num, AmountRecord> _amountStrings = {};

  Map<num, AmountRecord> get amountStrings => _amountStrings;

  static const circularRangeFinderPercentChange = .05;

  Future<void> queryFood(int id) async {
    final foodsDB =
        di.get<FoodsDB>(instanceName: LocatorInstanceNames.foodsDBService);

    final foodDTO = await foodsDB.queryFood(id: id);
    final food = Food.fromFoodDTO(foodDTO!);

    currentFood.value = food;

    _amountStrings = await food.createAmountStrings();
  }

  void changeUnits(RotationDirection direction) {
    final newMap = <num, AmountRecord>{};
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
    final amounts = await currentFood.value!.createAmountStrings();
    _amountStrings = amounts;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    currentFood.dispose();
    _amountStrings.clear();
  }
}
