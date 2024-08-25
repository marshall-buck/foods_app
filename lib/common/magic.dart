enum DisplayMode { light, dark }

enum LocatorName { foodsDBService }

enum PreferenceKeys { colorMode, quickSearchAmounts, savedFoods }

/// This would be (food id, saved amount)
typedef SavedFoodRecord = (String, String);

final String defaultModeValue = DisplayMode.light.name;
final List<String> defaultQuickSearchValue = ['1003', '1004', '1005', '1008'];
