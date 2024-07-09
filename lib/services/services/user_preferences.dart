import 'package:foods_app/common/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceKeys {
  quickSearch('quickSearch'),
  colorTheme('colorTheme');

  const PreferenceKeys(this.key);
  final String key;
}

class UserPreferencesService {
  late final SharedPreferences _prefs;
  late final String _mode;
  late final List<String> _quickSearch;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    if (_prefs.containsKey(PreferenceKeys.quickSearch.key)) {
      _quickSearch = _prefs.getStringList(PreferenceKeys.quickSearch.key)!;
    } else {
      await _prefs.setStringList(
          PreferenceKeys.quickSearch.key, QuickSearch.defaults);
    }
    if (_prefs.containsKey(PreferenceKeys.colorTheme.key)) {
      _mode = _prefs.getString(PreferenceKeys.colorTheme.key)!;
    } else {
      await _prefs.setStringList(
          PreferenceKeys.colorTheme.key, QuickSearch.defaults);
    }
  }

  String get mode => _mode;

  List<String> get quickSearch => _quickSearch;
}
