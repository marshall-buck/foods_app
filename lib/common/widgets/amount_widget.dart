import 'package:flutter/material.dart';
import 'package:foods_app/common/extensions.dart';

// TODO: Change to use AmountHolder
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
    return Text(
      '${amount.convertAmountToString()}  $unit',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor),
      maxLines: 1, //Limit the number of lines
      overflow: TextOverflow.fade,
    );
  }
}
