import 'package:equatable/equatable.dart';
import 'package:usda_db_package/usda_db_package.dart';

//TODO: Integrate external api factory's here

/// {@template food_dto}
/// A class that represents the data for a food object.
///
/// The purpose is to convert the API data into a base data class for the domain layer to use.
/// {@endtemplate}
class FoodDTO extends Equatable {
  /// {@macro food_dto}
  const FoodDTO({
    required this.id,
    required this.description,
    required this.nutrients,
  });

  /// Creates a [FoodDTO] instance from the local Usda DB [UsdaFoodModel] object.
  factory FoodDTO.fromUsdaFoodModel(UsdaFoodModel food) {
    return FoodDTO(
      id: food.id,
      description: food.description,
      nutrients: food.nutrients,
    );
  }

  /// The unique identifier of the food.
  final int id;

  /// The description of the food.
  final String description;

  /// A map of nutrient id's to their amounts in the food.
  final Map<int, double> nutrients;

  @override
  List<Object?> get props => [id, description, nutrients];

  @override
  bool get stringify => true;
}
