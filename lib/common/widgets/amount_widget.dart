import 'package:flutter/material.dart';

import 'package:foods_app/common/extensions.dart';
import 'package:foods_app/common/widgets/painters/triangle.dart';

/// A widget that displays an amount with a unit, adjusted by a modifier from the AdjustAmountBloc.
/// The amount passed is the original food/nutrient amount, and is multiplied by the original amount.
class AmountWidget extends StatelessWidget {
  const AmountWidget({
    required this.textColor,
    required this.amount,
    required this.unit,
    super.key,
  });
  final Color textColor;
  final double amount;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox.square(
          dimension: 48,
          child: CustomPaint(
            // size: const Size.square(48),
            painter: TrianglePainter(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        Text(
          '${amount.convertAmountToString()}  $unit',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor),
          maxLines: 1, //Limit the number of lines
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }
}
