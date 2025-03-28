import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/adjust_amount/adjust_amount.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/domain/domain.dart';

import 'package:foods_app/food_detail/food_detail.dart';

class NutrientCompareCard extends StatelessWidget {
  const NutrientCompareCard({required this.nutrientId, required this.foods, super.key});

  final int nutrientId;
  final List<Food?> foods;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(
          MagicBorderRadius.br_16,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: MagicSpacing.sp_4),
            child: _NutrientCardTitle(
              id: nutrientId,
            ),
          ),
          Expanded(child: _NutrientAmountDisplays(foods: foods, nutrientId: nutrientId)),
        ],
      ),
    );

    //
  }
}

class _NutrientAmountDisplays extends StatelessWidget {
  const _NutrientAmountDisplays({
    required this.foods,
    required this.nutrientId,
  });

  final List<Food?> foods;
  final int nutrientId;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: foods.map((food) {
        return _NutrientAmountDisplay(
          nutrientId: nutrientId,
          food: food!,
          foodIndex: foods.indexOf(food), // Ensure the index is unique for each food item
        );
      }).toList(),
    );
  }
}

class _NutrientAmountDisplay extends StatelessWidget {
  const _NutrientAmountDisplay({required this.nutrientId, required this.food, required this.foodIndex});

  final int nutrientId;
  final Food food;
  final int foodIndex;

  void _onLongPressed(BuildContext context) {
    final amount = food.nutrientAmount(nutrientId);
    final unit = food.getNutrientUnit(nutrientId);
    // if (amount == 0) {
    //   return; // Avoid showing the slider if the amount is zero
    // }
    context.read<FoodDetailBloc>().add(const ModifyAmountFoodDetailEvent());
    Navigator.of(context).push(
      CircularRangeSliderPopUp<void>(
        context: context,
        amount: amount,
        unit: unit,
        index: foodIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 108, maxWidth: 108),
      child: SharedAmountDisplay(
        amount: food.nutrientAmount(nutrientId),
        unit: food.getNutrientUnit(nutrientId),
        index: foodIndex,
        onLongPress: _onLongPressed,
      ),
    );
  }
}

class _NutrientCardTitle extends StatelessWidget {
  const _NutrientCardTitle({required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final state = context.read<FoodDetailBloc>().state;
    return AutoHyphenatingText(state.getNutrientNameById(id));
  }
}
