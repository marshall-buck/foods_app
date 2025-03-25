import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/adjust_amount/adjust_amount.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/domain/domain.dart';

import 'package:foods_app/food_detail/bloc/food_detail_bloc.dart';

class NutrientCompareCard extends StatelessWidget {
  const NutrientCompareCard({required this.nutrientId, required this.foods, super.key});

  final int nutrientId;
  final List<Food?> foods;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(MagicBorderRadius.br_10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: MagicSpacing.sp_4),
            child: _NutrientCardTitle(
              id: nutrientId,
            ),
          ),
          Expanded(child: _NutrientDice(foods: foods, nutrientId: nutrientId)),
        ],
      ),
    );

    //
  }
}

class _NutrientDice extends StatelessWidget {
  const _NutrientDice({
    required this.foods,
    required this.nutrientId,
  });

  final List<Food?> foods;
  final int nutrientId;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemSize = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth / (foods.length > 3 ? 3 : 2)
            : constraints.maxHeight / (foods.length > 3 ? 3 : 2);

        return Wrap(
          runSpacing: 8,
          spacing: 8,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          children: foods.map((food) {
            return SizedBox(
              width: itemSize - 8,
              height: itemSize - 8,
              child: _NutrientItem(
                nutrientId: nutrientId,
                food: food!,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _NutrientItem extends StatelessWidget {
  const _NutrientItem({
    required this.nutrientId,
    required this.food,
  });

  final int nutrientId;
  final Food food;

  void _onLongPressed(BuildContext context) {
    final amount = food.nutrientAmount(nutrientId);
    final unit = food.getNutrientUnit(nutrientId);
    if (amount == 0) {
      return; // Avoid showing the slider if the amount is zero
    }
    context.read<FoodDetailBloc>().add(const ModifyAmountFoodDetailEvent());
    Navigator.of(context).push(
      CircularRangeSliderPopUp<void>(context: context, amount: amount, unit: unit),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: () => _onLongPressed(context),
        child: ClipOval(
          child: ColoredBox(
            color: Theme.of(context).colorScheme.surfaceBright,
            child: Center(
              child: BlocSelector<FoodDetailBloc, FoodDetailState, double>(
                selector: (state) {
                  return state.modifier;
                },
                builder: (context, state) {
                  return AmountWidget(
                    textColor: Theme.of(context).colorScheme.onSurface,
                    amount: food.nutrientAmount(nutrientId) * state,
                    unit: food.getNutrientUnit(nutrientId),
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

class _NutrientCardTitle extends StatelessWidget {
  const _NutrientCardTitle({required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final state = context.read<FoodDetailBloc>().state;
    return AutoHyphenatingText(state.getNutrientNameById(id));
  }
}
