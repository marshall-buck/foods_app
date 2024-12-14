// ignore: unused_import
import 'dart:developer' as dev;

import 'package:flutter/widgets.dart';

import 'package:foods_app/domain/domain.dart';

import 'package:foods_app/ui/core/core.dart';

import 'package:watch_it/watch_it.dart';

class FoodAmountManager extends ChangeNotifier {
  Map<int, AmountRecord> _amountStrings = {};

  Map<int, AmountRecord> get amountStrings => _amountStrings;

  static const circularRangeFinderPercentChange = .05;

  void initAmountStrings(Food food) {
    _amountStrings = food.createAmountStrings();
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

  void resetToOriginalAmounts() {
    final currentFood = di.get<AppHistoryState>().lastFood;
    final amounts = currentFood!.createAmountStrings();
    _amountStrings = amounts;
    notifyListeners();
  }

  void clearAmounts() => _amountStrings.clear();

  @override
  void dispose() {
    // _amountStrings.clear();
    notifyListeners();
    super.dispose();
  }
}
