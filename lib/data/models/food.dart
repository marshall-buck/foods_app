import 'package:flutter/foundation.dart';
import 'package:usda_db_package/usda_db_package.dart';

import 'nutrient.dart';

@immutable
class FoodModel {
  final int id;
  final String description;
  final List<Nutrient> nutrients;

  const FoodModel(
      {required this.id, required this.description, required this.nutrients});

  static FoodModel? fromUsdaDB(SrLegacyFoodModel? food) {
    if (food == null) return null;
    // final List<Nutrient> nutrients = [];
    // for (SrLegacyNutrientModel nutrient in food.nutrients) {
    //   final Nutrient nut = Nutrient.fromUsdaDB(nutrient);
    //   nutrients.add(nut);
    // }

    final List<Nutrient> nutrients =
        food.nutrients.map((e) => Nutrient.fromUsdaDB(e)).toList();
    return FoodModel(
        id: food.id, description: food.description, nutrients: nutrients);
  }

  factory FoodModel.fromExternalDB() => throw UnimplementedError();
}
