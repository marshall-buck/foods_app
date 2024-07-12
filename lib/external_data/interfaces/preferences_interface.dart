import 'dart:async';

/// This would be (food id, saved amount)
typedef SavedFoodRecord = (int, int);

abstract interface class PreferencesService {
  static const String quickSearchKey = 'quickSearch';
  static const String colorThemeKey = 'colorTheme';
  static const String favoriteFoodsKey = 'favoriteFoods';
  static const String savedFoodsKey = 'savedFoods';

  String get colorTheme;

  /// Keeps track of what numbers the user wants to see in the search results. The
  /// String would be an id of a nutrient item.
  List<String> get quickSearch;

  /// Foods marked as favorites. The int would be an id of a food item.
  List<String> get favoriteFoods;

  /// Saved foods would be a certain amount of a food.
  List<SavedFoodRecord>? get savedFoods;

  /// Initiate the preferences
  FutureOr<void> init();
}
