import 'dart:async';

/// This would be (food id, saved amount)
typedef SavedFoodRecord = (int, int);

abstract interface class PreferencesService {
  FutureOr<void> init();
  get colorTheme;

  /// Keeps track of what numbers the user want to see in the search results. The
  /// int would be an id of a nutrient item"
  List<int> get quickSearch;

  /// Foods marked as favorites.  The int would an id of a food item.
  Iterable<int> get favoriteFoods;

  /// Saved foods would be a certain amount of a food.
  SavedFoodRecord get savedFoods;
}
