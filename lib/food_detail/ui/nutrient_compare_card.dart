import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/adjust_amount/adjust_amount.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/domain/domain.dart';

import 'package:foods_app/food_detail/food_detail.dart';

/// {@template nutrient_compare_card}
/// A card widget that displays nutrient information for a specific nutrient
/// across multiple foods.
/// {@endtemplate}
class NutrientCompareCard extends StatelessWidget {
  /// {@macro nutrient_compare_card}
  const NutrientCompareCard({
    required this.nutrientId,
    required this.foods,
    super.key,
  });

  /// The ID of the nutrient being displayed.
  final int nutrientId;

  /// The list of foods to compare.
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
          Expanded(
            child: _NutrientAmountDisplays(
              foods: foods,
              nutrientId: nutrientId,
            ),
          ),
        ],
      ),
    );
  }
}

/// {@template nutrient_amount_displays}
/// A widget that displays the nutrient amounts for a specific nutrient
/// across multiple foods.
/// {@endtemplate}
class _NutrientAmountDisplays extends StatelessWidget {
  /// {@macro nutrient_amount_displays}
  const _NutrientAmountDisplays({
    required this.foods,
    required this.nutrientId,
  });

  /// The list of foods to display.
  final List<Food?> foods;

  /// The ID of the nutrient being displayed.
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
          foodIndex: foods.indexOf(food),
        );
      }).toList(),
    );
  }
}

/// {@template nutrient_amount_display}
/// A widget that displays the nutrient amount for a specific food.
/// {@endtemplate}
class _NutrientAmountDisplay extends StatelessWidget {
  /// {@macro nutrient_amount_display}
  const _NutrientAmountDisplay({
    required this.nutrientId,
    required this.food,
    required this.foodIndex,
  });

  /// The ID of the nutrient being displayed.
  final int nutrientId;

  /// The food being displayed.
  final Food food;

  /// The index of the food in the list.
  final int foodIndex;

  void _onLongPressed(BuildContext context) {
    final amount = food.nutrientAmount(nutrientId);
    final unit = food.getNutrientUnit(nutrientId);
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

/// {@template nutrient_card_title}
/// A widget that displays the title of a nutrient card.
/// {@endtemplate}
class _NutrientCardTitle extends StatelessWidget {
  /// {@macro nutrient_card_title}
  const _NutrientCardTitle({required this.id});

  /// The ID of the nutrient being displayed.
  final int id;

  @override
  Widget build(BuildContext context) {
    final state = context.read<FoodDetailBloc>().state;
    return AutoHyphenatingText(state.getNutrientNameById(id));
  }
}
