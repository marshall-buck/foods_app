import 'package:flutter/material.dart';
import 'package:foods_app/domain/domain.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    required this.textColor,
    required this.id,
    required this.food,
    super.key,
  });
  final Color textColor;
  final int id;
  final Food food;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${food.amountStrings[id]!.$2} ${food.amountStrings[id]!.$3}',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor),
      maxLines: 1, //Limit the number of lines
      overflow: TextOverflow.fade,
    );
  }
}
