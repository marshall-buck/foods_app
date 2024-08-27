import 'dart:async';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/external_data/external_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedUserPrefsServiceImp
    implements
        DisplayModePrefs<String>,
        PreferencesService<SharedPreferencesAsync> {
  @override
  late final SharedPreferencesAsync prefProvider;

  SharedUserPrefsServiceImp(this.prefProvider);

  @override
  FutureOr<String> getDisplayMode() async {
    try {
      final colorMode =
          await prefProvider.getString(PreferenceKeys.displayMode);
      return colorMode as String;
    } catch (e) {
      return DisplayMode.system;
    }
  }

  @override
  FutureOr<void> setDisplayMode<String>({required String value}) async {
    try {
      await prefProvider.setString(PreferenceKeys.displayMode, value);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  FutureOr<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }
}
