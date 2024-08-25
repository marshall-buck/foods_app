import 'dart:async';

import 'package:flutter/foundation.dart';

abstract interface class PreferencesService<T> {
  late final T prefProvider;

  FutureOr<void> init();
}

abstract interface class ColorModePref<T> {
  late final String colorModeKey;
  late final ValueNotifier<T> colorMode;
  Future<void> setColorMode<K>(K value);
  Future<K> getColorMode<K>();
}

abstract interface class QuickSearchPrefs<T> {
  late final String quickSearchAmountsKey;
  late final ValueNotifier<T> quickSearchAmounts;
  Future<void> setQuickSearchAmounts<K>(K value);
  Future<K> getQuickSearchAmounts<K>();
}
