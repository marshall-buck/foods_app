import 'package:equatable/equatable.dart';
import 'package:foods_app/services/services_B.dart';

class FoodListItem extends Equatable {
  final String description;
  final List<Nutrient> nutrients;

  const FoodListItem({required this.description, required this.nutrients});

  factory FoodListItem.fromFoodModel(
      FoodModel food, List<String> quickSearchPrefs) {
    final List<Nutrient> amounts = quickSearchPrefs
        .map((id) => food.nutrients.firstWhere((n) => n.id.toString() == id))
        .toList();

    return FoodListItem(description: food.description, nutrients: amounts);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [description, nutrients];
}
