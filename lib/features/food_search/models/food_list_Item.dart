import 'package:equatable/equatable.dart';
import 'package:foods_app/external_data/external_data.dart';

class FoodListItemModel extends Equatable {
  final int id;
  final String description;
  final List<Nutrient> nutrients;

  const FoodListItemModel(
      {required this.id, required this.description, required this.nutrients});

  factory FoodListItemModel.fromFoodModel(
      FoodModel food, List<String> quickSearchPrefs) {
    final List<Nutrient> quickSearchNutrients = quickSearchPrefs
        .map((id) => food.nutrients.firstWhere(
              (n) => n.id.toString() == id,
              orElse: () =>
                  const Nutrient(id: 0, name: 'name', amount: 0, unit: 'unit'),
            ))
        .toList();

    return FoodListItemModel(
        id: food.id,
        description: food.description,
        nutrients: quickSearchNutrients);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [description, nutrients];
}
