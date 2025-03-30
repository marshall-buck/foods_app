import 'package:equatable/equatable.dart';

import 'package:foods_app/data/data.dart';

/// {@template food_list_item_model}
/// A model representing a food item in the list.
///
/// This model is used to represent a food item with its unique identifier,
/// description, and a list of nutrient amounts for quick results.
/// {@endtemplate}
class FoodListItemModel extends Equatable {
  /// {@macro food_list_item_model}
  const FoodListItemModel({
    required this.id,
    required this.description,
    required this.quickResultsAmountsList,
  });

  /// Creates a [FoodListItemModel] from a [FoodDTO] object.
  ///
  /// This factory constructor maps the properties of a [FoodDTO] object
  /// and a list of nutrient amounts to create a [FoodListItemModel].
  ///
  /// - [food]: The [FoodDTO] object containing the food data.
  /// - [nutrientAmounts]: A list of nutrient amounts for quick results.
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

  /// The unique identifier of the food item.
  final int id;

  /// The description of the food item.
  final String description;

  /// A list of nutrient amounts for quick results.
  final List<String> quickResultsAmountsList;

  @override
  List<Object?> get props => [id, description, quickResultsAmountsList];
}
