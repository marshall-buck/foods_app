import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foods_app/data/data.dart';

part 'adjust_amount_event.dart';
part 'adjust_amount_state.dart';

class AdjustAmountBloc extends Bloc<AdjustAmountEvent, AdjustAmountState> {
  AdjustAmountBloc({
    required ActiveFoods activeFoods,
  })  : _activeFoods = activeFoods,
        super(AdjustAmountState(modifier: activeFoods.activeModifier)) {
    on<AdjustAmountEvent>(_changeUnits);
  }
  final ActiveFoods _activeFoods;

  static const circularRangeFinderPercentChange = .05;

// //TODO: Change to extension on double
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

  /// This is called in the CircularRangeSlider when the user rotates the handle.

  void _changeUnits(AdjustAmountEvent event, Emitter<AdjustAmountState> emit) {
    final currentModifier = _activeFoods.activeModifier;

    final percentage = event.add == true
        ? (1 + (circularRangeFinderPercentChange / 100))
        : (1 - (circularRangeFinderPercentChange / 100));
    _activeFoods.changeModifier(percentage * currentModifier);

    log('_activeFoods.activeModifier ${_activeFoods.activeModifier}');

    // for (final en in _amountStrings.entries) {
    //   final key = en.key;
    //   final oldValue = en.value.$1;
    //   final unit = en.value.$3;

    //   final amountModifier = _adjustAmountModifier(currentItem!);

    //   // (amountModifier / 100) calculates a percentage based on the amountModifier.
    //   // Adding/Subtracting 1 to this percentage and multiplying it by the oldValue
    //   // effectively increases/decreases the oldValue by the specified percentage.

    //   final newValue = add == true ? oldValue * (1 + (amountModifier / 100)) : oldValue * (1 - (amountModifier / 100));

    //   // newMap[key] = (newValue, Food.convertAmountToString(newValue), unit);
    // }
    // _amountStrings = newMap;
  }
  // /// This is called in the CircularRangeSlider when the user rotates the handle.
  // void changeUnits(RotationDirection direction, int id) {
  //   assert(
  //     _amountStrings.isNotEmpty,
  //     'FoodAmountManager: _amountStrings is empty',
  //   );
  //   final newMap = <int, AmountRecord>{};
  //   final currentItem = _amountStrings[id]?.$1;
  //   for (final en in _amountStrings.entries) {
  //     final key = en.key;
  //     final oldValue = en.value.$1;
  //     final unit = en.value.$3;

  //     final amountModifier = _adjustAmountModifier(currentItem!);

  //     // (amountModifier / 100) calculates a percentage based on the amountModifier.
  //     // Adding/Subtracting 1 to this percentage and multiplying it by the oldValue
  //     // effectively increases/decreases the oldValue by the specified percentage.

  //     final newValue = direction == RotationDirection.clockwise
  //         ? oldValue * (1 + (amountModifier / 100))
  //         : oldValue * (1 - (amountModifier / 100));

  //     newMap[key] = (newValue, Food.convertAmountToString(newValue), unit);
  //   }
  //   _amountStrings = newMap;

  // }
}
