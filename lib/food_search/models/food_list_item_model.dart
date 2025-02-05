import 'package:equatable/equatable.dart';

import 'package:foods_app/data/data.dart';

/// A class that represents the data for a food list item.
///
/// This class is responsible for storing food list item data, including its
/// ID, description, and a list of quick results.  Quick results are the
/// amounts of 4 nutrients based on user preferences.
///
/// The [FoodListItemModel] class can be initialized by providing the food's
/// [id], [description], and [quickResultsList], or by using the
/// [fromFoodDTO]  constructor.
///
/// The [fromFoodDTO] factory constructor creates a [FoodListItemModel]
/// instance from a [FoodDTO] object.

class FoodListItemModel extends Equatable {
  const FoodListItemModel({
    required this.id,
    required this.description,
    required this.quickResultsList,
  });

  static Future<FoodListItemModel> fromFoodDTO(
    FoodDTO food,
    LocalUserPrefsRepo quickPrefs,
  ) async {
    return FoodListItemModel(
      id: food.id,
      description: food.description,
      quickResultsList: await _quickSearchNutrientAmounts(
        food,
        quickPrefs,
      ),
    );
  }

  final int id;
  final String description;
  final List<String> quickResultsList;

  FoodListItemModel copyWith({
    int? id,
    String? description,
    List<String>? quickResultsList,
  }) {
    return FoodListItemModel(
      id: id ?? this.id,
      description: description ?? this.description,
      quickResultsList: quickResultsList ?? this.quickResultsList,
    );
  }

  // Returns a list of nutrient amounts for the food, based on the user's
  // quick search preferences.
  static Future<List<String>> _quickSearchNutrientAmounts(
    FoodDTO food,
    LocalUserPrefsRepo quickPrefs,
  ) async {
    final prefs = await quickPrefs.getQuickSearchAmounts();
    final nutrients = food.nutrients;
    final matches = <String>[];
    for (final string in prefs) {
      final id = int.parse(string);

      if (nutrients.containsKey(id)) {
        matches.add(nutrients[id].toString());
      } else {
        matches.add('0');
      }
    }

    return matches.reversed.toList();
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, description, quickResultsList];
}
