import 'package:flutter/foundation.dart';
import 'package:foods_app/data/data.dart';
import 'package:usda_db_package/usda_db_package.dart';

import 'nutrient.dart';

@immutable
class FoodModel {
  final int id;
  final String description;
  final List<Nutrient> nutrients;

  const FoodModel(
      {required this.id, required this.description, required this.nutrients});

  factory FoodModel.fromUsdaDB(SrLegacyFoodType food) {
    final List<Nutrient> nutrients = food.nutrients
        .map((SrLegacyNutrientType e) => Nutrient.fromUsdaDB(e))
        .toList();
    return FoodModel(
        id: food.id, description: food.description, nutrients: nutrients);
  }

  factory FoodModel.fromExternalDB() => throw UnimplementedError();
}
