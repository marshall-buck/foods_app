import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/domain/domain.dart';

import 'package:foods_app/food_detail/bloc/food_detail_bloc.dart';

import 'package:foods_app/food_detail/ui/ui.dart';

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
          _NutrientCardTitle(
            id: nutrientId,
          ),
          Expanded(child: NutrientDice(foods: foods, nutrientId: nutrientId)),
        ],
      ),
    );

    //
  }
}

class NutrientDice extends StatelessWidget {
  const NutrientDice({
    required this.foods,
    required this.nutrientId,
    super.key,
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
              child: NutrientItem(
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

class NutrientItem extends StatelessWidget {
  const NutrientItem({
    required this.nutrientId,
    required this.food,
    super.key,
  });

  final int nutrientId;
  final Food food;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: () {},
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
                    amount: food.nutrientAmount(state, nutrientId),
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
