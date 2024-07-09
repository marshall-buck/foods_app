import 'package:foods_app/common/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceKeys {
  quickSearch('quickSearch'),
  colorTheme('colorTheme');

  const PreferenceKeys(this.key);
  final String key;
}

class PreferencesNotInitializedException implements Exception {
  final String message;
  PreferencesNotInitializedException(this.message);

  @override
  String toString() => 'PreferencesNotInitializedException: $message';
}

class UserPreferencesService {
  SharedPreferences? _prefs;
  late final String? _mode;
  late final List<String>? _quickSearch;

  UserPreferencesService(this._prefs);

  String? get mode => _mode;

  List<String>? get quickSearch => _quickSearch;

  Future<void> init() async {
    if (_prefs == null) {
      throw PreferencesNotInitializedException(
          'SharedPreferences is not initialized.');
    }
    await _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    _quickSearch = await _getOrSetDefaultList(
      PreferenceKeys.quickSearch.key,
      QuickSearch.defaults,
    );
    _mode = await _getOrSetDefaultString(
      PreferenceKeys.colorTheme.key,
      DisplayMode.light,
    );
  }

  Future<List<String>> _getOrSetDefaultList(
      String key, List<String> defaultValue) async {
    if (_prefs == null) {
      throw PreferencesNotInitializedException(
          'SharedPreferences is not initialized.');
    }
    if (_prefs!.containsKey(key)) {
      return _prefs!.getStringList(key) ?? defaultValue;
    } else {
      await _prefs!.setStringList(key, defaultValue);
      return defaultValue;
    }
  }

  Future<String> _getOrSetDefaultString(String key, String defaultValue) async {
    if (_prefs == null) {
      throw PreferencesNotInitializedException(
          'SharedPreferences is not initialized.');
    }
    if (_prefs!.containsKey(key)) {
      final value = _prefs!.get(key);
      if (value is String) {
        return value;
      } else {
        // Handle the case where the value is not a string
        throw PreferencesNotInitializedException(
            'Expected a String for key $key but found ${value.runtimeType}');
      }
    } else {
      await _prefs!.setString(key, defaultValue);
      return defaultValue;
    }
  }
}

// class UserPreferencesService {
//   SharedPreferences? _prefs;
//   late final String? _mode;
//   late final List<String>? _quickSearch;

//   UserPreferencesService(this._prefs);

//   String? get mode => _mode;

//   List<String>? get quickSearch => _quickSearch;

//   Future<void> init() async {
//     await _initializePreferences();
//   }

//   Future<void> _initializePreferences() async {
//     if (_prefs != null) {
//       _quickSearch = await _getOrSetDefaultList(
//         PreferenceKeys.quickSearch.key,
//         QuickSearch.defaults,
//       );
//       _mode = await _getOrSetDefaultString(
//         PreferenceKeys.colorTheme.key,
//         'defaultMode',
//       );
//     } else {
//       // Handle the case where _prefs is null
//       _quickSearch = QuickSearch.defaults;
//       _mode = 'defaultMode';
//     }
//   }

//   Future<List<String>> _getOrSetDefaultList(
//       String key, List<String> defaultValue) async {
//     if (_prefs != null && _prefs!.containsKey(key)) {
//       return _prefs!.getStringList(key) ?? defaultValue;
//     } else {
//       if (_prefs != null) {
//         await _prefs!.setStringList(key, defaultValue);
//       }
//       return defaultValue;
//     }
//   }

//   Future<String> _getOrSetDefaultString(String key, String defaultValue) async {
//     if (_prefs != null && _prefs!.containsKey(key)) {
//       return _prefs!.getString(key) ?? defaultValue;
//     } else {
//       if (_prefs != null) {
//         await _prefs!.setString(key, defaultValue);
//       }
//       return defaultValue;
//     }
//   }
// }
