import 'dart:async';

/// This would be (food id, saved amount)
typedef SavedFoodRecord = (int, int);

abstract interface class PreferencesServiceInterface {
  static const String quickSearchKey = 'quickSearch';
  static const String colorThemeKey = 'colorTheme';
  static const String favoriteFoodsKey = 'favoriteFoods';

  late final String _colorTheme;
  late final List<String> _quickSearch;
  late final Iterable<int>? _favoriteFoods;

  String get colorTheme => _colorTheme;

  /// Keeps track of what numbers the user want to see in the search results. The
  /// String would be an id of a nutrient item"
  List<String> get quickSearch => _quickSearch;

  /// Foods marked as favorites.  The int would an id of a food item.
  Iterable<int>? get favoriteFoods => _favoriteFoods;

  /// Saved foods would be a certain amount of a food.
  SavedFoodRecord? get savedFoods;

  FutureOr<void> init();
}
