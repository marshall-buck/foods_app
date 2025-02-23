import 'package:equatable/equatable.dart';

import 'package:foods_app/data/data.dart';

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
      quickResultsAmountsList: quickResultsAmountsList ?? this.quickResultsAmountsList,
    );
  }

  @override
  List<Object?> get props => [id, description, quickResultsAmountsList];
}
