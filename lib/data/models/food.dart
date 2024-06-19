import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:usda_db_package/usda_db_package.dart';

import 'nutrient.dart';
part 'food.freezed.dart';

@freezed
class FoodModel with _$FoodModel {
  const factory FoodModel(
      {required int id,
      required String description,
      required List<Nutrient> nutrients}) = _FoodModel;

  static FoodModel? fromUsdaDB(SrLegacyFoodModel? food) {
    if (food == null) return null;

    final List<Nutrient> nutrients =
        food.nutrients.map((e) => Nutrient.fromUsdaDB(e)).toList();
    return FoodModel(
        id: food.id, description: food.description, nutrients: nutrients);
  }

  factory FoodModel.fromExternalDB() => throw UnimplementedError();
}
