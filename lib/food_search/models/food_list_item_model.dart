import 'package:equatable/equatable.dart';

import 'package:foods_app/data/data.dart';

/// A class that represents the data for a food list item.
///
/// This class is responsible for storing food list item data, including its
/// ID, description, and a list of quick results.  Quick results are the
/// amounts of 4 nutrients based on user preferences.
///
/// The [FoodListItemModel] class can be initialized by providing the food's
/// [id], [description], and [quickResultsAmountsList], or by using the
/// [fromFoodDAO]  constructor.
///
/// The [fromFoodDAO] factory constructor creates a [FoodListItemModel]
/// instance from a [FoodDAO] object.

class FoodListItemModel extends Equatable {
  const FoodListItemModel({
    required this.id,
    required this.description,
    required this.quickResultsAmountsList,
  });

  static Future<FoodListItemModel> fromFoodDAO({
    required FoodDAO food,
    required List<String> nutrientAmounts,
  }) async {
    return FoodListItemModel(
      id: food.id,
      description: food.description,
      quickResultsAmountsList: nutrientAmounts,
    );
  }

  final int id;
  final String description;
  final List<String> quickResultsAmountsList;

  FoodListItemModel copyWith({
    int? id,
    String? description,
    List<String>? quickResultsAmountsList,
  }) {
    return FoodListItemModel(
      id: id ?? this.id,
      description: description ?? this.description,
      quickResultsAmountsList:
          quickResultsAmountsList ?? this.quickResultsAmountsList,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, description, quickResultsAmountsList];
}
