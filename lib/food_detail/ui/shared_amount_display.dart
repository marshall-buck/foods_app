import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:foods_app/common/common.dart';

import 'package:foods_app/food_detail/bloc/food_detail_bloc.dart';

class SharedAmountDisplay extends StatelessWidget {
  const SharedAmountDisplay({
    required this.amount,
    required this.unit,
    required this.index,
    required this.onLongPress,
    super.key,
  });

  final double amount;
  final String unit;
  final int index;
  final void Function(BuildContext context) onLongPress;

  @override
  Widget build(BuildContext context) {
    final tileSize = MagicTileDimension.tileSize(
      windowSize: MediaQuery.sizeOf(context).shortestSide,
    );
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size.square(tileSize.dimension)), // Ensure the widget is square

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
