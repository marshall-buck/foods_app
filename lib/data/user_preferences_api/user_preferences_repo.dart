import 'dart:async';
import 'dart:developer';

import 'package:foods_app/common/common.dart';

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
  UserPrefsRepository({required SharedPreferencesAsync prefProvider})
      : _prefProvider = prefProvider;

  late final SharedPreferencesAsync _prefProvider;

  final StreamController<List<String>> _savedFoodsController =
      StreamController<List<String>>.broadcast();

  final StreamController<List<String>> _quickSearchIdsController =
      StreamController<List<String>>.broadcast();

  final StreamController<String> _displayModeController =
      StreamController<String>.broadcast();

  Stream<List<String>> get savedFoodsStream => _savedFoodsController.stream;
  Stream<List<String>> get quickSearchIdsStream =>
      _quickSearchIdsController.stream;
  Stream<String> get displayModeStream => _displayModeController.stream;

  List<String> get quickSearchIds =>
      _quickSearchIdsController.stream.toList() as List<String>;

  @override
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

  Future<void> _initQuickSearchIds() async {
    try {
      final quickSearchPrefs =
          await _prefProvider.getStringList(_PreferenceKeys.quickSearchIds);
      if (quickSearchPrefs == null) {
        await _prefProvider.setStringList(
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
      // return _DefaultPreferences.defaultQuickSearchIds;
    }
  }

  Future<String> getDisplayMode() async {
    try {
      final colorMode =
          await _prefProvider.getString(_PreferenceKeys.displayMode);

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
      await _prefProvider.setString(_PreferenceKeys.displayMode, value);
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

  // Future<void> getQuickSearchIds() async {
  //   try {
  //     final quickSearchPrefs =
  //         await prefProvider.getStringList(_PreferenceKeys.quickSearchIds);
  //     _quickSearchIdsController
  //         .add(quickSearchPrefs ?? _DefaultPreferences.defaultQuickSearchIds);
  //   } catch (e, st) {
  //     log(
  //       runtimeType.toString(),
  //       time: DateTime.now(),
  //       error: e,
  //       stackTrace: st,
  //       name: 'getQuickSearchAmounts()',
  //     );
  //     // return _DefaultPreferences.defaultQuickSearchIds;
  //   }
  // }

  Future<void> setQuickSearchIds(List<String> value) async {
    try {
      await _prefProvider.setStringList(
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
          await _prefProvider.getStringList(_PreferenceKeys.savedFoods);
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
      await _prefProvider.setStringList(_PreferenceKeys.savedFoods, value);
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
