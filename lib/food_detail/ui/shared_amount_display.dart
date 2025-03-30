import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:foods_app/common/common.dart';

import 'package:foods_app/food_detail/bloc/food_detail_bloc.dart';

/// {@template shared_amount_display}
/// A widget that displays an amount and unit,
///
/// The passed amount will be  multiplied by the modifier in the [FoodDetailBloc] state.
///
/// It supports a long-press action for additional interactions.
/// {@endtemplate}
class SharedAmountDisplay extends StatelessWidget {
  /// {@macro shared_amount_display}
  const SharedAmountDisplay({
    required this.amount,
    required this.unit,
    required this.index,
    required this.onLongPress,
    super.key,
  });

  /// The base amount to display.
  final double amount;

  /// The unit of the amount.
  final String unit;

  /// The index of the item being displayed.
  final int index;

  /// The callback triggered on a long press.
  final void Function(BuildContext context) onLongPress;

  @override
  Widget build(BuildContext context) {
    final amountDisplaySize = MagicTileDimension.tileSize(
      windowSize: MediaQuery.sizeOf(context).shortestSide,
    );
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size.square(amountDisplaySize.dimension)), // Ensure the widget is square
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: () => onLongPress(context),
        child: ClipOval(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: Center(
              child: BlocSelector<FoodDetailBloc, FoodDetailState, double>(
                selector: (state) => state.modifier,
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
    );
  }
}
