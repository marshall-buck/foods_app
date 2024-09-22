import 'dart:async';
import 'dart:developer' as dev;

import 'package:foods_app/common/common.dart';
import 'package:foods_app/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _PreferenceKeys {
  static const String displayMode = 'displayMode';
  static const String quickSearchAmounts = 'quickSearchAmounts';

  static const String savedFoods = 'savedFoods';
}

class _DefaultPreferences {
  static const List<String> defaultQuickSearchValue = [
    '1003',
    '1004',
    '1005',
    '1008',
  ];

  static const defaultDisplayMode = DisplayMode.system;
}

class SharedUserPrefsServiceImp
    implements PreferencesService<SharedPreferencesAsync> {
  SharedUserPrefsServiceImp(this.prefProvider);
  @override
  late final SharedPreferencesAsync prefProvider;

  @override
  Future<void> init() async {
    try {
      final keys = await prefProvider.getKeys();
      if (keys.isEmpty) {
        await setDisplayMode(DisplayMode.system);
        await setQuickSearchAmounts(
          _DefaultPreferences.defaultQuickSearchValue,
        );
        await setSavedFoods([]);
      }
    } catch (e, st) {
      dev.log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'init()',
      );
    }
  }

  @override
  Future<String> getDisplayMode() async {
    try {
      final colorMode =
          await prefProvider.getString(_PreferenceKeys.displayMode);

      return colorMode ?? _DefaultPreferences.defaultDisplayMode;
    } catch (e, st) {
      dev.log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'getDisplayMode()',
      );
      return _DefaultPreferences.defaultDisplayMode;
    }
  }

  @override
  Future<void> setDisplayMode(String value) async {
    try {
      await prefProvider.setString(_PreferenceKeys.displayMode, value);
    } catch (e, st) {
      dev.log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'setDisplayMode()',
      );
    }
  }

  @override
  Future<List<String>> getQuickSearchAmounts() async {
    try {
      final quickSearchPrefs =
          await prefProvider.getStringList(_PreferenceKeys.quickSearchAmounts);
      return quickSearchPrefs ?? _DefaultPreferences.defaultQuickSearchValue;
    } catch (e, st) {
      dev.log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'getQuickSearchAmounts()',
      );
      return _DefaultPreferences.defaultQuickSearchValue;
    }
  }

  @override
  Future<void> setQuickSearchAmounts(List<String> value) async {
    try {
      await prefProvider.setStringList(
        _PreferenceKeys.quickSearchAmounts,
        value,
      );
    } catch (e, st) {
      dev.log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'setQuickSearchAmounts()',
      );
    }
  }

  @override
  Future<List<String>> getSavedFoods() async {
    try {
      final savedFoods =
          await prefProvider.getStringList(_PreferenceKeys.savedFoods);
      return savedFoods ?? [];
    } catch (e, st) {
      dev.log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'getSavedFoods()',
      );
      return [];
    }
  }

  @override
  Future<void> setSavedFoods(List<String> value) async {
    try {
      await prefProvider.setStringList(_PreferenceKeys.savedFoods, value);
    } catch (e, st) {
      dev.log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'setSavedFoods()',
      );
    }
  }
}
