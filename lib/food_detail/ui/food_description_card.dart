import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/adjust_amount/adjust_amount.dart';
import 'package:foods_app/common/common.dart';

import 'package:foods_app/domain/domain.dart';
import 'package:foods_app/food_detail/food_detail.dart';

class FoodDescriptionCard extends StatelessWidget {
  const FoodDescriptionCard({
    required this.food,
    required this.index,
    super.key,
  });

  final Food food;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isEven = index.isEven;
    return Row(
      children: [
        if (isEven) ...[
          _FoodAmountDisplay(
            food: food,
            index: index,
          ),
          _Description(food: food, textAlign: TextAlign.start),
        ] else ...[
          _Description(
            food: food,
            textAlign: TextAlign.end,
          ),
          _FoodAmountDisplay(
            food: food,
            index: index,
          ),
        ],
      ],
    );
  }
}

class _FoodAmountDisplay extends StatelessWidget {
  const _FoodAmountDisplay({required this.food, required this.index});

  final Food food;
  final int index;

  void _onLongPress(BuildContext context) {
    context.read<FoodDetailBloc>().add(const ModifyAmountFoodDetailEvent());
    Navigator.of(context).push(
      CircularRangeSliderPopUp<void>(context: context, amount: food.defaultAmount, unit: food.unit, index: index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size.square(108)),
      child: SharedAmountDisplay(
        amount: food.defaultAmount,
        unit: food.unit,
        index: index,
        onLongPress: _onLongPress,
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({required this.food, required this.textAlign});

  final Food food;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    if (textAlign == TextAlign.start) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: MagicSpacing.sp_1),
          child: Text(
            textAlign: textAlign,
            food.name,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 3, //Limit the number of lines
            overflow: TextOverflow.ellipsis, //Handle overflow with ellipsis
          ),
        ),
      );
    } else {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: MagicSpacing.sp_1),
          child: Text(
            textAlign: textAlign,
            food.name,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 3, //Limit the number of lines
            overflow: TextOverflow.ellipsis, //Handle overflow with ellipsis
          ),
        ),
      );
    }
  }
}
