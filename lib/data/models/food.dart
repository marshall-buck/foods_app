import 'package:usda_db_package/usda_db_package.dart';

import 'nutrient.dart';

class FoodModel {
  const FoodModel(
      {required int id,
      required String description,
      required List<Nutrient> nutrients});

  static FoodModel? fromUsdaDB(SrLegacyFoodModel? food) {
    if (food == null) return null;

    final List<Nutrient> nutrients =
        food.nutrients.map((e) => Nutrient.fromUsdaDB(e)).toList();
    return FoodModel(
        id: food.id, description: food.description, nutrients: nutrients);
  }

  factory FoodModel.fromExternalDB() => throw UnimplementedError();
}
