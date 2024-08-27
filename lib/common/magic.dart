/// This would be (food id, saved amount)
typedef SavedFoodRecord = (String, String);
final List<String> defaultQuickSearchValue = ['1003', '1004', '1005', '1008'];

class PreferenceKeys {
  static const String displayMode = 'displayMode';
  static const String quickSearchAmounts = 'quickSearchAmounts';
  static const String savedFoods = 'savedFoods';
}

class DisplayMode {
  static const String light = 'light';

  static const String dark = 'dark';
  static const String system = 'system';
}

class LocatorName {
  static const String foodsDBService = 'foodsDBService';
}
