import 'dart:async';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _PreferenceKeys {
  static const String displayMode = 'displayMode';
  static const String quickSearchAmounts = 'quickSearchAmounts';
  // ignore: unused_field
  static const String savedFoods = 'savedFoods';
}

class SharedUserPrefsServiceImp
    implements PreferencesService<SharedPreferencesAsync> {
  @override
  late final SharedPreferencesAsync prefProvider;

  SharedUserPrefsServiceImp(this.prefProvider);

  static const List<String> defaultQuickSearchValue = [
    '1003',
    '1004',
    '1005',
    '1008'
  ];

  @override
  Future<void> init() async {
    final keys = await prefProvider.getKeys();
    if (keys.isEmpty) {
      await setDisplayMode(DisplayMode.system);
      await setQuickSearchAmounts(defaultQuickSearchValue);
    }
  }

  @override
  Future<String> getDisplayMode() async {
    try {
      final colorMode =
          await prefProvider.getString(_PreferenceKeys.displayMode);
      return colorMode ?? DisplayMode.system;
    } catch (e) {
      return DisplayMode.system;
    }
  }

  @override
  Future<void> setDisplayMode(value) async {
    try {
      await prefProvider.setString(_PreferenceKeys.displayMode, value);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<List<String>> getQuickSearchAmounts() async {
    try {
      final quickSearchPrefs =
          await prefProvider.getStringList(_PreferenceKeys.quickSearchAmounts);
      return quickSearchPrefs ?? defaultQuickSearchValue;
    } catch (e) {
      return defaultQuickSearchValue;
    }
  }

  @override
  Future<void> setQuickSearchAmounts(List<String> value) async {
    try {
      await prefProvider.setStringList(
          _PreferenceKeys.quickSearchAmounts, value);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<List<String>> getSavedFoods() async {
    try {
      final savedFoods =
          await prefProvider.getStringList(_PreferenceKeys.savedFoods);
      return savedFoods ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> setSavedFoods(List<String> value) async {
    try {
      await prefProvider.setStringList(_PreferenceKeys.savedFoods, value);
    } catch (e) {
      print(e.toString());
    }
  }
}
