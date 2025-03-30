import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/adjust_amount/adjust_amount.dart';
import 'package:foods_app/common/common.dart';

import 'package:foods_app/domain/domain.dart';
import 'package:foods_app/food_detail/food_detail.dart';

/// {@template food_description_card}
/// A widget that displays a detailed description of a food item.
///
/// Alternates the layout of the description and amount display based on the index.
/// {@endtemplate}
class FoodDescriptionCard extends StatelessWidget {
  /// {@macro food_description_card}
  const FoodDescriptionCard({
    required this.food,
    required this.index,
    super.key,
  });

  /// The food item to display.
  final Food food;

  /// The index of the food item in the list.
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

/// {@template food_amount_display}
/// A widget that displays the amount and unit of a food item.
///
/// Supports long press to adjust the amount.
/// {@endtemplate}
class _FoodAmountDisplay extends StatelessWidget {
  /// {@macro food_amount_display}
  const _FoodAmountDisplay({required this.food, required this.index});

  /// The food item to display.
  final Food food;

  /// The index of the food item in the list.
  final int index;

  void _onLongPress(BuildContext context) {
    context.read<FoodDetailBloc>().add(const ModifyAmountFoodDetailEvent());
    Navigator.of(context).push(
      CircularRangeSliderPopUp<void>(
        context: context,
        amount: food.defaultAmount,
        unit: food.unit,
        index: index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SharedAmountDisplay(
      amount: food.defaultAmount,
      unit: food.unit,
      index: index,
      onLongPress: _onLongPress,
    );
  }
}

/// {@template food_description}
/// A widget that displays the name of a food item with text alignment.
/// {@endtemplate}
class _Description extends StatelessWidget {
  /// {@macro food_description}
  const _Description({required this.food, required this.textAlign});

  /// The food item to display.
  final Food food;

  /// The text alignment for the description.
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
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
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
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
  }
}
