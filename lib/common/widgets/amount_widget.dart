import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

/// A widget that displays an amount with a unit, adjusted by a modifier from the AdjustAmountBloc.
/// The amount passed is the original food/nutrient amount, and is multiplied by the original amount.
class AmountWidget extends StatelessWidget {
  const AmountWidget({
    // required this.textColor,
    required this.amount,
    required this.unit,
    required this.index,
    super.key,
  });
  // final Color textColor;
  final double amount;
  final String unit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox.square(
          dimension: 48,
          child: CustomPaint(
            // size: const Size.square(48),
            painter: ShapeCornersPainter(
              numberOfCorners: index + 1,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              radius: 8,
            ),
          ),
        ),
        Text(
          '${amount.convertAmountToString()}  $unit',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
          maxLines: 1, //Limit the number of lines
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }
}
