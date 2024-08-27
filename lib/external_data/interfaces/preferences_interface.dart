import 'dart:async';

import 'package:flutter/foundation.dart';

abstract interface class PreferencesService<T> {
  late final T prefProvider;

  FutureOr<void> init();

  // Future<void> setColorMode<ColorModePref>(ColorModePref value);
  // Future<ColorModePref> getColorMode<ColorModePref>();
}

abstract interface class DisplayModePrefs<T> {
  FutureOr<T> getDisplayMode();
  FutureOr<void> setDisplayMode<K>({required K value});
}

abstract interface class QuickSearchPrefs<T> {
  late final String quickSearchAmountsKey;
  late final ValueNotifier<T> quickSearchAmounts;
  Future<void> setQuickSearchAmounts<K>(K name);
  Future<K> getQuickSearchAmounts<K>();
}
