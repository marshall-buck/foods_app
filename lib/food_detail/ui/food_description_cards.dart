import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/domain/domain.dart';
import 'package:foods_app/food_detail/food_detail.dart';

/// {@template food_description_cards}
/// A widget that displays a list of food description cards.
///
/// Each card represents a food amount and its description.
/// {@endtemplate}
class FoodDescriptionCards extends StatelessWidget {
  /// {@macro food_description_cards}
  const FoodDescriptionCards({required this.foods, super.key});

  /// The list of food items to display.
  final List<Food?> foods;

  @override
  Widget build(BuildContext context) {
    final amountDisplaySize = MagicTileDimension.tileSize(
      windowSize: MediaQuery.sizeOf(context).shortestSide,
    );

    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final food = foods[index];
        //TODO:Might not need the sized box, as the SharedAmountDisplay is constrained.
        return SizedBox(
          height: amountDisplaySize.dimension,
          child: FoodDescriptionCard(
            food: food!,
            index: index,
          ),
        );
      },
    );
  }
}
