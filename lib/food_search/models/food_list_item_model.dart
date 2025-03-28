import 'package:equatable/equatable.dart';

import 'package:foods_app/data/data.dart';

/// {@template food_list_item_model}
/// A model representing a food item in the list.
/// {@endtemplate}
class FoodListItemModel extends Equatable {
  /// {@macro food_list_item_model}
  const FoodListItemModel({
    required this.id,
    required this.description,
    required this.quickResultsAmountsList,
  });

  /// Creates a [FoodListItemModel] from a [FoodDTO] object.
  factory FoodListItemModel.fromFoodDTO({
    required FoodDTO food,
    required List<String> nutrientAmounts,
  }) {
    return FoodListItemModel(
      id: food.id,
      description: food.description,
      quickResultsAmountsList: nutrientAmounts,
    );
  }

  final int id;
  final String description;
  final List<String> quickResultsAmountsList;

  @override
  List<Object?> get props => [id, description, quickResultsAmountsList];
}
