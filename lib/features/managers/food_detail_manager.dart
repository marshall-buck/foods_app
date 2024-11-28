import 'dart:developer' as dev;
import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/services/services.dart';
import 'package:foods_app/widgets/widgets.dart';

import 'package:watch_it/watch_it.dart';

class FoodDetailManager extends ChangeNotifier {
  final currentFood = ValueNotifier<Food?>(null);

  final Map<num, (num, String)> _adjustedNutrientAmounts = {};
  final Map<num, (num, String)> _adjustedFoodAmount = {};

  Map<num, (num, String)> get adjustedNutrientAmounts =>
      _adjustedNutrientAmounts;

  Map<num, (num, String)> get adjustedFoodAmount => _adjustedFoodAmount;

  Map<num, (num, String)> get amountStrings => {
        ..._adjustedFoodAmount,
        ..._adjustedNutrientAmounts,
      };

  Future<void> queryFood(int id) async {
    final foodsDB = di.get<FoodsDB>(instanceName: LocatorName.foodsDBService);
    final food = await foodsDB.queryFood(id: id);
    currentFood.value = Food.fromFoodDTO(food!);
    await _initAdjustedAmounts();
  }

  // /// Returns the percentage difference of the new food amount from the
  // /// original (100) as decimal percentage.
  // num _calculatePercentageChange(num newFoodAmount) =>
  //     (newFoodAmount - originalFoodAmount) / 100;

  // num applyPercentageChange(num percentageChange, num oldValue) =>
  //     oldValue + (oldValue * percentageChange);

  void _adjustFoodValue(RotationDirection direction) {
    final oldValue = _adjustedFoodAmount[currentFood.value!.id]!.$1;
    // dev.log('$oldValue', name: ' adjustFoodValue - oldValue');

    final newValue = direction == RotationDirection.clockwise
        ? oldValue * (1 + (circularRangeFinderPercentChange / 100))
        : oldValue * (1 - (circularRangeFinderPercentChange / 100));

    dev.log('$newValue', name: ' adjustFoodValue - newValue');

    _adjustedFoodAmount[currentFood.value!.id] =
        (newValue, _convertAmountToString(newValue));

    // return newValue;
  }

  void _adjustNutrientValues(RotationDirection direction) {
    for (final en in _adjustedNutrientAmounts.entries) {
      final key = en.key;
      final oldValue = en.value.$1;

      final newValue = direction == RotationDirection.clockwise
          ? oldValue * (1 + (circularRangeFinderPercentChange / 100))
          : oldValue * (1 - (circularRangeFinderPercentChange / 100));

      _adjustedNutrientAmounts[key] =
          (newValue, _convertAmountToString(newValue));
    }
  }

  void changeUnits(RotationDirection direction) {
    _adjustFoodValue(direction);
    _adjustNutrientValues(direction);

    notifyListeners();
  }

  void resetToOriginalAmounts() {
    _initAdjustedAmounts();
    notifyListeners();
  }

  String _convertAmountToString(num amount) {
    if (amount >= 10) {
      return amount.toStringAsFixed(0);
    }
    if (amount < 10 && amount >= 1) {
      return amount.toStringAsFixed(2);
    }
    return amount.toStringAsFixed(3);
  }

  /// Populate the late properties _adjustedFoodAmount,_adjustedNutrientAmounts.
  /// Called in queryFoods and resetToOriginalAmounts.
  Future<void> _initAdjustedAmounts() async {
    assert(
      currentFood.value?.foodAmount != null,
      'FoodDetailManager _populateAmounts() - There is no current food',
    );
    assert(
      currentFood.value?.nutrientList != null,
      'FoodDetailManager _populateAmounts() - There is no current nutrientList',
    );
    // init _adjustedFoodAmount
    _adjustedFoodAmount[currentFood.value!.id] = (
      currentFood.value!.foodAmount,
      _convertAmountToString(currentFood.value!.foodAmount)
    );

    // init _adjustedNutrientAmounts
    for (final item in currentFood.value!.nutrientList) {
      final amount = item.amount;
      final displayString = _convertAmountToString(amount);
      _adjustedNutrientAmounts[item.id] = (item.amount, displayString);

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
