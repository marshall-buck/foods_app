import 'package:equatable/equatable.dart';
import 'package:foods_app/services/services.dart';
import 'package:usda_db_package/usda_db_package.dart';

class FoodModel extends Equatable {
  const FoodModel({
    required this.id,
    required this.description,
    required this.nutrients,
  });

  factory FoodModel.fromUsdaDB(SrLegacyFoodModel food) {
    final nutrients = food.nutrients.map(Nutrient.fromUsdaDB).toList();
    return FoodModel(
      id: food.id,
      description: food.description,
      nutrients: nutrients,
    );
  }

  // factory FoodModel.fromExternalDB() => throw UnimplementedError();
  final int id;
  final String description;
  final List<Nutrient> nutrients;

  @override
  List<Object?> get props => [id, description, nutrients];

  @override
  bool get stringify => true;
}
