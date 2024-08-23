import 'dart:async';

/// This would be (food id, saved amount)
typedef SavedFoodRecord = (int, int);

abstract interface class PreferencesService {
  /// Whether there are saved settings or not?
  void setHasSettings(bool value);
  bool getHasSettings();

  /// Color theme.
  void setColorTheme(String value);
  String getColorTheme(String value);

  /// A list of Nutrient id's to use to retrieve the amounts to show in autocomplete.
  void setQuickSearchPrefs(List<String> value);
  List<String> getQuickSearchPrefs();

  /// Initiate the preferences
  FutureOr<void> init();
}
