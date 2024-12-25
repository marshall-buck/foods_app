import 'package:equatable/equatable.dart';
import 'package:foods_app/common/common.dart';

import 'package:foods_app/data/data.dart';
import 'package:watch_it/watch_it.dart';

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
  ) async {
    final quickResultsList = await _quickSearchNutrientAmounts(food);
    return FoodListItemModel(
      id: food.id,
      description: food.description,
      quickResultsList: quickResultsList,
    );
  }

  final int id;
  final String description;
  final List<String> quickResultsList;

  /// Returns a list of nutrient amounts for the food, based on the user's
  /// quick search preferences.
  static Future<List<String>> _quickSearchNutrientAmounts(FoodDTO food) async {
    // ignore: strict_raw_type
    final prefs = di.get<PreferencesService>(
      instanceName: LocatorInstanceNames.sharedPrefsService,
    );
    final quickPrefs = await prefs.getQuickSearchAmounts();
    final nutrients = food.nutrients;
    final matches = <String>[];
    for (final string in quickPrefs) {
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
  List<Object?> get props => [description, quickResultsList];
}
