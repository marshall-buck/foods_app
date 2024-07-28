import 'package:foods_app/common/constants.dart';
import 'package:foods_app/common/exceptions.dart';
import 'package:foods_app/external_data/external_services_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesServiceI implements PreferencesService {
  final SharedPreferences? _prefs;

  late final String _colorTheme;
  late final List<String> _favoriteFoods;
  late final List<String> _quickSearch;
  late final List<SavedFoodRecord>? _savedFoods;

  @override
  String get colorTheme => _colorTheme;

  @override
  List<String> get favoriteFoods => _favoriteFoods;

  @override
  List<String> get quickSearch => _quickSearch;

  @override
  List<SavedFoodRecord>? get savedFoods => _savedFoods;

  UserPreferencesServiceI(this._prefs);

  @override
  Future<void> init() async {
    if (_prefs == null) {
      throw PreferencesNotInitializedException(
          'SharedPreferences is not initialized.');
    }
    await _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    _quickSearch = await _getOrSetDefaultList(
      PreferencesService.quickSearchKey,
      QuickSearch.defaults,
    );
    _colorTheme = await _getOrSetDefaultString(
      PreferencesService.colorThemeKey,
      DisplayMode.light,
    );
  }

  Future<List<String>> _getOrSetDefaultList(
      String key, List<String> defaultValue) async {
    if (_prefs == null) {
      throw PreferencesNotInitializedException(
          'SharedPreferences is not initialized.');
    }
    if (_prefs.containsKey(key)) {
      return _prefs.getStringList(key) ?? defaultValue;
    } else {
      await _prefs.setStringList(key, defaultValue);
      return defaultValue;
    }
  }

  Future<String> _getOrSetDefaultString(String key, String defaultValue) async {
    if (_prefs == null) {
      throw PreferencesNotInitializedException(
          'SharedPreferences is not initialized.');
    }
    if (_prefs.containsKey(key)) {
      final value = _prefs.get(key);
      if (value is String) {
        return value;
      } else {
        // Handle the case where the value is not a string
        throw PreferencesNotInitializedException(
            'Expected a String for key $key but found ${value.runtimeType}');
      }
    } else {
      await _prefs.setString(key, defaultValue);
      return defaultValue;
    }
  }
}
