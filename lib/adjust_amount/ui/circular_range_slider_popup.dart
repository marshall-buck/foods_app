import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/adjust_amount/adjust_amount.dart';

import 'package:foods_app/common/common.dart';

// TODO: use speed indicator icons to adjust speed.

/// A popup route that displays a circular range slider for adjusting amounts.
///
/// This popup is used to adjust a specific amount and unit, and it interacts
/// with the [AdjustAmountBloc] to update the state based on user input.
///
/// {@template CircularRangeSliderPopUp}
/// Creates a [CircularRangeSliderPopUp].
/// {@endtemplate}
class CircularRangeSliderPopUp<T> extends PopupRoute<T> {
  /// {@macro CircularRangeSliderPopUp}
  /// - [context] is the build context.
  /// - [amount] is the initial amount to be adjusted.
  /// - [unit] is the unit of the amount (e.g., grams, liters).
  /// - [index] is the index of the item being adjusted.
  CircularRangeSliderPopUp({required this.context, required this.amount, required this.unit, required this.index});

  /// The build context of the popup.
  final BuildContext context;

  /// The initial amount to be adjusted.
  final double amount;

  /// The unit of the amount (e.g., grams, liters).
  final String unit;

  /// The index of the item being adjusted.
  final int index;

  @override
  Color? get barrierColor => Theme.of(context).colorScheme.primaryContainer.withValues(alpha: MagicOpacity.op_70);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Center(
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleLarge!,
        child: UnconstrainedBox(
          child: ClipOval(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: CircularRangeSlider(
                // logging: true,
                onPanUpdate: (direction, details) {
                  context
                      .read<AdjustAmountBloc>()
                      .add(AdjustAmountEvent(add: direction == RotationDirection.clockwise));
                },
                trackStroke: MagicNumbers.circularRangeSliderTrackStroke,
                handleRadius: MagicNumbers.circularRangeSliderHandleRadius,
                handleColor: Theme.of(context).colorScheme.error,
                trackDiameter: MagicNumbers.circularRangeSliderTrackDiameter,
                trackColor: Theme.of(context).colorScheme.primary,
                child: BlocSelector<AdjustAmountBloc, AdjustAmountState, double>(
                  selector: (state) {
                    return state.modifier;
                  },
                  builder: (context, state) {
                    return AmountWidget(
                      amount: amount * state,
                      unit: unit,
                      index: index,
                      iconSize: MagicNumbers.circularRangeFinderAmountWidgetIconSize,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
