import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/services/services.dart';
import 'package:watch_it/watch_it.dart';

class FoodDetailManager extends ChangeNotifier {
  final currentFood = ValueNotifier<Food?>(null);

  // String? get description => currentFood.value?.description;
  // num? get id => currentFood.value?.id;
  // num? get foodAmount => currentFood.value?.foodAmount;
  // Map<int, Nutrient>? get nutrientMap => currentFood.value?.nutrientMap;
  // List<Nutrient>? get nutrientList => currentFood.value?.nutrientList;

  late Map<num, num> _amountsActual;
  late Map<num, String> _amountsString;

  Map<num, String> get amountString => _amountsString;
  Map<num, num> get amountsActual => _amountsActual;

  Future<void> queryFood(int id) async {
    final foodsDB = di.get<FoodsDB>(instanceName: LocatorName.foodsDBService);
    final food = await foodsDB.queryFood(id: id);
    currentFood.value = Food.fromFoodDTO(food!);
    _populateAmounts();
  }

  void changeUnits(double modifier) {
    dev.log(
      '$modifier',
      name: 'FoodDetailManager - changeUnits modifier:  ',
    );
    final newActual = <num, num>{};
    final newString = <num, String>{};
    for (final en in _amountsActual.entries) {
      final key = en.key;
      final value = en.value;
      final newValue = value + (modifier / 100);

      newActual[key] = newValue;
      newString[key] = newValue.toStringAsFixed(1);
    }
    _amountsActual = Map.unmodifiable(newActual);
    _amountsString = Map.unmodifiable(newString);

    notifyListeners();
  }

  void resetToOriginalAmounts() {
    _populateAmounts();
    notifyListeners();
  }

  void _populateAmounts() {
    assert(
      currentFood.value != null,
      'FoodDetailManager _populateAmounts() - There is no current food',
    );
    _amountsActual = {currentFood.value!.id: currentFood.value!.foodAmount};
    _amountsString = {
      currentFood.value!.id: currentFood.value!.foodAmount.toStringAsFixed(1),
    };
    for (final item in currentFood.value!.nutrientList) {
      _amountsActual[item.id] = item.amount;
      _amountsString[item.id] = item.amount.toStringAsFixed(1);
      dev.log(
        '$item',
        name: 'FoodDetailManager - _populateAmounts amounts:  ',
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    currentFood.dispose();
  }
}
