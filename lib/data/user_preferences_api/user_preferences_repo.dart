import 'dart:async';
import 'dart:developer';

import 'package:foods_app/common/common.dart';

import 'package:rxdart/subjects.dart';

import 'package:shared_preferences/shared_preferences.dart';

class _PreferenceKeys {
  static const String displayMode = 'displayMode';
  static const String quickSearchIds = 'quickSearchIds';

  static const String savedFoods = 'savedFoods';
}

class _DefaultPreferences {
  static const List<String> defaultQuickSearchIds = [
    '1003',
    '1004',
    '1005',
    '1008',
  ];

  static const defaultDisplayMode = DisplayMode.system;

  static const defaultSavedFoods = <String>[];
}

class UserPrefsRepository {
  UserPrefsRepository({required SharedPreferencesAsync prefPlugin})
      : _prefPlugin = prefPlugin;
  late final SharedPreferencesAsync _prefPlugin;

  // final StreamController<List<String>> _savedFoodsController =
  //     StreamController<List<String>>();

  final _quickSearchIdsController = BehaviorSubject<List<String>>();

  Stream<List<String>> get quickSearchIdsStream =>
      _quickSearchIdsController.stream.asBroadcastStream();

  List<String> get currentQuickSearchIds =>
      _quickSearchIdsController.valueOrNull ??
      _DefaultPreferences.defaultQuickSearchIds;

  // final StreamController<String> _displayModeController =
  //     StreamController<String>();

  Future<void> init() async {
    try {
      await _initQuickSearchIds();
    } on Exception catch (e, st) {
      log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'init()',
      );
    }
  }

  // List<String> createQuickSearchNames(List<String> ids) => ids
  //   ..map((id) {
  //     return NutrientDAO.originalNutrientTableEdit[int.parse(id)]!['name']!;
  //   }).toList().reversed.toList();

  Future<void> _initQuickSearchIds() async {
    try {
      final quickSearchPrefs =
          await _prefPlugin.getStringList(_PreferenceKeys.quickSearchIds);
      if (quickSearchPrefs == null) {
        await _prefPlugin.setStringList(
          _PreferenceKeys.quickSearchIds,
          _DefaultPreferences.defaultQuickSearchIds,
        );
        _quickSearchIdsController
            .add(_DefaultPreferences.defaultQuickSearchIds);
      } else {
        _quickSearchIdsController.add(quickSearchPrefs);
      }
    } catch (e, st) {
      log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'getQuickSearchAmounts()',
      );
    }
  }

  Future<String> getDisplayMode() async {
    try {
      final colorMode =
          await _prefPlugin.getString(_PreferenceKeys.displayMode);

      return colorMode ?? _DefaultPreferences.defaultDisplayMode;
    } catch (e, st) {
      log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'getDisplayMode()',
      );
      return _DefaultPreferences.defaultDisplayMode;
    }
  }

  Future<void> setDisplayMode(String value) async {
    try {
      await _prefPlugin.setString(_PreferenceKeys.displayMode, value);
    } catch (e, st) {
      log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'setDisplayMode()',
      );
    }
  }

  Future<void> setQuickSearchIds(List<String> value) async {
    try {
      await _prefPlugin.setStringList(
        _PreferenceKeys.quickSearchIds,
        value,
      );
    } catch (e, st) {
      log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'setQuickSearchAmounts()',
      );
    }
  }

  Future<List<String>> getSavedFoods() async {
    try {
      final savedFoods =
          await _prefPlugin.getStringList(_PreferenceKeys.savedFoods);
      return savedFoods ?? _DefaultPreferences.defaultSavedFoods;
    } catch (e, st) {
      log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'getSavedFoods()',
      );
      return [];
    }
  }

  Future<void> setSavedFoods(List<String> value) async {
    try {
      await _prefPlugin.setStringList(_PreferenceKeys.savedFoods, value);
    } catch (e, st) {
      log(
        runtimeType.toString(),
        time: DateTime.now(),
        error: e,
        stackTrace: st,
        name: 'setSavedFoods()',
      );
    }
  }
}
