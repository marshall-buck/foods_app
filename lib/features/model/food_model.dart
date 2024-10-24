import 'package:equatable/equatable.dart';
import 'package:foods_app/services/services.dart';

class Food extends Equatable {
  const Food(
      {required this.id,
      required this.description,
      required this.nutrientMap,
      required this.nutrientList});
  factory Food.fromFoodDTO(FoodDTO food) {
    final nutrientMap = <int, Nutrient>{};
    final nutrientList = <Nutrient>[];
    for (final entry in food.nutrients.entries) {
      final nutrient = Nutrient.fromMapEntry(entry);
      nutrientMap[entry.key] = nutrient;
      nutrientList.add(nutrient);
    }
    return Food(
        id: food.id,
        description: food.description,
        nutrientMap: nutrientMap,
        nutrientList: nutrientList);
  }
  final int id;

  final String description;

  final Map<int, Nutrient> nutrientMap;
  final List<Nutrient> nutrientList;

  @override
  List<Object?> get props => [id, description, nutrientMap, nutrientList];
}

class Nutrient extends Equatable {
  const Nutrient({
    required this.id,
    required this.name,
    required this.amount,
    required this.unit,
  });

  /// Creates a [Nutrient] instance from a MapEntry<int, num> object.
  factory Nutrient.fromMapEntry(MapEntry<int, num> entry) {
    final id = entry.key;
    final amount = entry.value;
    return Nutrient(
      id: id,
      name: NutrientDTO.originalNutrientTableEdit[id]?['name'] ?? '',
      amount: amount,
      unit: NutrientDTO.originalNutrientTableEdit[id]?['unit'] ?? '',
    );
  }

  final int id;
  final String name;
  final num amount;
  final String unit;

  @override
  List<Object?> get props => [id, name, amount, unit];
}
