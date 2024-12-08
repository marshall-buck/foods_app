import 'package:flutter/material.dart';
import 'package:foods_app/features/features.dart';
import 'package:watch_it/watch_it.dart';

class AmountWidget extends WatchingWidget {
  const AmountWidget({
    required this.textColor,
    required this.id,
    super.key,
  });
  final Color textColor;
  final int id;

  @override
  Widget build(BuildContext context) {
    final amountStrings =
        watchPropertyValue((FoodDetailManager m) => m.amountStrings);
    assert(amountStrings[id]?.$2 != null, 'The string is empty');

    return Text(
      '${amountStrings[id]!.$2} ${amountStrings[id]!.$3}',
      textAlign: TextAlign.center,
      style:
          Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor),
    );
  }
}
