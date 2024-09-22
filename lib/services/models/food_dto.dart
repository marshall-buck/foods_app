import 'package:equatable/equatable.dart';
import 'package:foods_app/services/services.dart';
import 'package:usda_db_package/usda_db_package.dart';

class FoodDTO extends Equatable {
  const FoodDTO({
    required this.id,
    required this.description,
    required this.nutrients,
  });

  factory FoodDTO.fromUsdaDB(SrLegacyFoodModel food) {
    return FoodDTO(
      id: food.id,
      description: food.description,
      nutrients: food.nutrients,
    );
  }

  Map<int, NutrientDTO> get allNutrientDTOs {
    final map = <int, NutrientDTO>{};
    for (final entry in nutrients.entries) {
      map[entry.key] = NutrientDTO.fromMapEntry(entry);
    }
    return map;
  }

  final int id;
  final String description;
  final Map<int, num> nutrients;

  @override
  List<Object?> get props => [id, description, nutrients, allNutrientDTOs];

  @override
  bool get stringify => true;
}
