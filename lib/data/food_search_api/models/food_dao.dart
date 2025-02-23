import 'package:equatable/equatable.dart';
import 'package:foods_app/data/data.dart';
import 'package:usda_db_package/usda_db_package.dart';

//TODO: Integrate external api factory's here

/// A class that represents the data for a food object.
/// The purpose is to convert external api data to a consistent model.
///
/// The [FoodDAO] class is initialized by providing the food's
/// [id], [description], and [nutrients].
///
/// The [allNutrientDTOs] getter returns a map of all nutrients for the food,
/// with the nutrient ID as the key and the [NutrientDAO] object as the value.

class FoodDAO extends Equatable {
  const FoodDAO({
    required this.id,
    required this.description,
    required this.nutrients,
  });

  /// Creates a [FoodDAO] instance from the local Usda DB [FoodDTO] object.
  factory FoodDAO.fromUsdaDB(FoodDTO food) {
    return FoodDAO(
      id: food.id,
      description: food.description,
      nutrients: food.nutrients,
    );
  }
  final int id;
  final String description;
  final Map<int, double> nutrients;

  /// Returns a map of all nutrients for a food instance.
  Map<int, NutrientDAO> get allNutrientDTOs {
    final map = <int, NutrientDAO>{};
    for (final entry in nutrients.entries) {
      map[entry.key] = NutrientDAO.fromMapEntry(entry);
    }
    return map;
  }

  @override
  List<Object?> get props => [id, description, nutrients, allNutrientDTOs];

  @override
  bool get stringify => true;
}
