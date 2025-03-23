import 'package:equatable/equatable.dart';
import 'package:foods_app/data/data.dart';
import 'package:usda_db_package/usda_db_package.dart';

// A class that represents the data for foods.
///
/// This class is responsible for storing food data, including its
/// ID, description, and nutrients.
///
/// The [FoodDTO] class is initialized by providing the food's
/// [id], [description], and [nutrients].
///
/// The [allNutrientDTOs] getter returns a map of all nutrients for the food,
/// with the nutrient ID as the key and the [NutrientDTO] object as the value.

class FoodDTO extends Equatable {
  const FoodDTO({
    required this.id,
    required this.description,
    required this.nutrients,
  });

  /// Creates a [FoodDTO] instance from a [SrLegacyFoodModel] object.
  factory FoodDTO.fromUsdaDB(UsdaFoodModel food) {
    return FoodDTO(
      id: food.id,
      description: food.description,
      nutrients: food.nutrients,
    );
  }

  /// Returns a map of all nutrients for the food.
  Map<int, NutrientDTO> get allNutrientDTOs {
    final map = <int, NutrientDTO>{};
    for (final entry in nutrients.entries) {
      map[entry.key] = NutrientDTO.fromMapEntry(entry);
    }
    return map;
  }

  final int id;
  final String description;
  final Map<int, double> nutrients;

  @override
  List<Object?> get props => [id, description, nutrients, allNutrientDTOs];

  @override
  bool get stringify => true;
}
