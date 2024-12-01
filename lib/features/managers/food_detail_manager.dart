import 'dart:developer' as dev;

import 'package:flutter/widgets.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/services/services.dart';
import 'package:foods_app/widgets/widgets.dart';

import 'package:watch_it/watch_it.dart';

// TODO:use force touch to change circularRangeFinderPercentChange

// (id, displayAmount, units)
typedef AmountRecord = (num, String, String);

class FoodDetailManager extends ChangeNotifier {
  final currentFood = ValueNotifier<Food?>(null);
  static const originalFoodAmount = 100.0;
  static const circularRangeFinderPercentChange = .05;

  final Map<num, AmountRecord> _adjustedNutrientAmounts = {};
  final Map<num, AmountRecord> _adjustedFoodAmount = {};

  Map<num, AmountRecord> get amountStrings => {
        ..._adjustedFoodAmount,
        ..._adjustedNutrientAmounts,
      };

  Future<void> queryFood(int id) async {
    final foodsDB = di.get<FoodsDB>(instanceName: LocatorName.foodsDBService);
    final food = await foodsDB.queryFood(id: id);
    currentFood.value = Food.fromFoodDTO(food!);
    await _initAdjustedAmounts();
  }

  void changeUnits(RotationDirection direction) {
    _adjustFoodValue(direction);
    _adjustNutrientValues(direction);

    notifyListeners();
  }

  void _adjustFoodValue(RotationDirection direction) {
    final oldValue = _adjustedFoodAmount[currentFood.value!.id]!.$1;

    final newValue = direction == RotationDirection.clockwise
        ? oldValue * (1 + (circularRangeFinderPercentChange / 100))
        : oldValue * (1 - (circularRangeFinderPercentChange / 100));

    dev.log('$newValue', name: ' adjustFoodValue - newValue');

    _adjustedFoodAmount[currentFood.value!.id] =
        (newValue, _convertAmountToString(newValue), 'g');
  }

  void _adjustNutrientValues(RotationDirection direction) {
    for (final en in _adjustedNutrientAmounts.entries) {
      final key = en.key;
      final oldValue = en.value.$1;
      final unit = en.value.$3;

      final newValue = direction == RotationDirection.clockwise
          ? oldValue * (1 + (circularRangeFinderPercentChange / 100))
          : oldValue * (1 - (circularRangeFinderPercentChange / 100));

      _adjustedNutrientAmounts[key] =
          (newValue, _convertAmountToString(newValue), unit);
    }
  }

  void resetToOriginalAmounts() {
    _initAdjustedAmounts();
    notifyListeners();
  }

  String _convertAmountToString(num amount) {
    if (amount >= 50) {
      return amount.toStringAsFixed(0);
    }
    if (amount < 50 && amount >= 10) {
      return amount.toStringAsFixed(1);
    }
    if (amount < 10 && amount >= 1) {
      return amount.toStringAsFixed(2);
    }
    return amount.toStringAsFixed(3);
  }

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
      _convertAmountToString(currentFood.value!.foodAmount),
      'g'
    );

    // init _adjustedNutrientAmounts
    for (final item in currentFood.value!.nutrientList) {
      final amount = item.amount;
      final unit = item.unit;
      final displayString = _convertAmountToString(amount);
      _adjustedNutrientAmounts[item.id] = (item.amount, displayString, unit);

      // dev.log(
      //   '$item',
      //   name: 'FoodDetailManager - _populateAmounts amounts:  ',
      // );
    }
  }

  @override
  void dispose() {
    super.dispose();
    currentFood.dispose();
    _adjustedFoodAmount.clear();
    _adjustedNutrientAmounts.clear();
  }
}
