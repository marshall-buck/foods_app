import 'package:equatable/equatable.dart';
import 'package:foods_app/external_data/external_services_B.dart';

class FoodListItemModel extends Equatable {
  final String description;
  final List<Nutrient> nutrients;

  const FoodListItemModel({required this.description, required this.nutrients});

  factory FoodListItemModel.fromFoodModel(
      FoodModel food, List<String> quickSearchPrefs) {
    final List<Nutrient> amounts = quickSearchPrefs
        .map((id) => food.nutrients.firstWhere((n) => n.id.toString() == id))
        .toList();

    return FoodListItemModel(description: food.description, nutrients: amounts);
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [description, nutrients];
}
