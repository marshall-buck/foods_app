import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/adjust_amount/adjust_amount.dart';

import 'package:foods_app/common/common.dart';

class CircularRangeSliderPopUp<T> extends PopupRoute<T> {
  CircularRangeSliderPopUp({required this.context, required this.amount, required this.unit, required this.index});
  final BuildContext context;
  final double amount;
  final String unit;
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
