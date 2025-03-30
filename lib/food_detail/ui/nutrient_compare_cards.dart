import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:foods_app/food_detail/bloc/food_detail_bloc.dart';

import 'package:foods_app/food_detail/ui/ui.dart';

/// {@template nutrient_compare_cards}
/// A widget that displays a  list of nutrient comparison cards
/// for the active foods in the [FoodDetailBloc] state.
///
/// Screen size and orientation will determine scroll direction.
///
/// {@endtemplate}
class NutrientCompareCards extends StatelessWidget {
  /// {@macro nutrient_compare_cards}
  const NutrientCompareCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodDetailBloc, FoodDetailState>(
      buildWhen: (previous, current) => previous.allNutrientIdsInQ != current.allNutrientIdsInQ,
      builder: (context, state) {
        final nutrientIds = state.allNutrientIdsInQ?.toList();
        final foods = state.foodsList;
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return AspectRatio(
              aspectRatio: 1,
              child: NutrientCompareCard(
                nutrientId: nutrientIds![index]!,
                foods: foods,
              ),
            );
          },
        );
      },
    );
  }
}
