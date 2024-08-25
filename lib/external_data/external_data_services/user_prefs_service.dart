import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/external_data/external_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesServiceImp
    implements
        PreferencesService<SharedPreferencesAsync>,
        ColorModePref<String>,
        QuickSearchPrefs<List<String>> {
  @override
  late final SharedPreferencesAsync prefProvider;

  UserPreferencesServiceImp(this.prefProvider);

  @override
  Future<void> init() async {
    // Initialize the SharedPreferences or any other setup if needed
    throw UnimplementedError();
  }

  @override
  ValueNotifier<String> colorMode = ValueNotifier<String>('_value');

  @override
  String colorModeKey = PreferenceKeys.colorMode.name;

  @override
  ValueNotifier<List<String>> quickSearchAmounts =
      ValueNotifier<List<String>>([]);

  @override
  String quickSearchAmountsKey = PreferenceKeys.quickSearchAmounts.name;

  @override
  Future<K> getColorMode<K>() {
    // TODO: implement getColorMode
    throw UnimplementedError();
  }

  @override
  Future<K> getQuickSearchAmounts<K>() {
    // TODO: implement getQuickSearchAmounts
    throw UnimplementedError();
  }

  @override
  Future<void> setColorMode<K>(K value) {
    // TODO: implement setColorMode
    throw UnimplementedError();
  }

  @override
  Future<void> setQuickSearchAmounts<K>(K value) {
    // TODO: implement setQuickSearchAmounts
    throw UnimplementedError();
  }
}
