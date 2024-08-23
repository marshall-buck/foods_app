import 'dart:async';

import 'package:foods_app/external_data/external_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesServiceI implements PreferencesService {
  UserPreferencesServiceI(this._sharedPrefs);
  final SharedPreferencesAsync _sharedPrefs;

  @override
  FutureOr<void> init() async {
    final prefsCheck = await _sharedPrefs.getAll();
    // if (prefsCheck.isEmpty) {
    //   hasSettings = true;
    // } else {
    //   hasSettings = false;
    // }
  }
}
