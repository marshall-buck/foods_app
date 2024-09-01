import 'package:equatable/equatable.dart';
import 'package:foods_app/services/services.dart';
import 'package:usda_db_package/usda_db_package.dart';

class FoodModel extends Equatable {
  const FoodModel(
      {required this.id, required this.description, required this.nutrients});
  final int id;
  final String description;
  final List<Nutrient> nutrients;

  static FoodModel fromUsdaDB(SrLegacyFoodModel food) {
    // if (food == null) return;

    final List<Nutrient> nutrients =
        food.nutrients.map((e) => Nutrient.fromUsdaDB(e)).toList();
    return FoodModel(
        id: food.id, description: food.description, nutrients: nutrients);
  }

  factory FoodModel.fromExternalDB() => throw UnimplementedError();

  @override
  List<Object?> get props => [id, description, nutrients];

  @override
  bool get stringify => true;
}
