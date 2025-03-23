// // ignore: unused_import
// import 'dart:developer' as dev;

// import 'package:flutter/widgets.dart';

// import 'package:foods_app/domain/domain.dart';

// import 'package:foods_app/ui/core/core.dart';

// import 'package:watch_it/watch_it.dart';

// class FoodAmountManager extends ChangeNotifier {
//   Map<int, AmountRecord> _amountStrings = {};

//   Map<int, AmountRecord> get amountStrings => _amountStrings;

//   static const circularRangeFinderPercentChange = .05;

//   void initAmountStrings(Food food) {
//     _amountStrings = food.createAmountStrings();
//   }

//   double _adjustAmountModifier(double amount) {
//     if (amount >= 50) {
//       return circularRangeFinderPercentChange * 2;
//     } else if (amount >= 10) {
//       return circularRangeFinderPercentChange * 2.1;
//     } else if (amount >= 1) {
//       return circularRangeFinderPercentChange * 2.3;
//     } else {
//       return circularRangeFinderPercentChange * 2.5;
//     }
//   }

//   /// This is called in the CircularRangeSlider when the user rotates the handle.
//   void changeUnits(RotationDirection direction, int id) {
//     assert(
//       _amountStrings.isNotEmpty,
//       'FoodAmountManager: _amountStrings is empty',
//     );
//     final newMap = <int, AmountRecord>{};
//     final currentItem = _amountStrings[id]?.$1;
//     for (final en in _amountStrings.entries) {
//       final key = en.key;
//       final oldValue = en.value.$1;
//       final unit = en.value.$3;

//       final amountModifier = _adjustAmountModifier(currentItem!);

//       // (amountModifier / 100) calculates a percentage based on the amountModifier.
//       // Adding/Subtracting 1 to this percentage and multiplying it by the oldValue
//       // effectively increases/decreases the oldValue by the specified percentage.

//       final newValue = direction == RotationDirection.clockwise
//           ? oldValue * (1 + (amountModifier / 100))
//           : oldValue * (1 - (amountModifier / 100));

//       newMap[key] = (newValue, Food.convertAmountToString(newValue), unit);
//     }
//     _amountStrings = newMap;
//     notifyListeners();
//   }

//   void resetToOriginalAmounts() {
//     final currentFood = di.get<AppHistoryState>().lastFood;
//     final amounts = currentFood!.createAmountStrings();
//     _amountStrings = amounts;
//     notifyListeners();
//   }

//   void clearAmounts() => _amountStrings.clear();

//   @override
//   void dispose() {
//     // _amountStrings.clear();
//     notifyListeners();
//     super.dispose();
//   }
// }
