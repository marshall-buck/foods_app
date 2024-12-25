import 'dart:async';

abstract interface class PreferencesService<T>
    implements
        DisplayModePrefs<String, String>,
        QuickSearchPrefs<String, List<String>>,
        SavedFoods<String, List<String>> {
  late final T prefProvider;

  Future<void> init();
}

abstract interface class DisplayModePrefs<K, V> {
  FutureOr<V> getDisplayMode();
  FutureOr<void> setDisplayMode(V value);
}

abstract interface class QuickSearchPrefs<K, V> {
  Future<void> setQuickSearchAmounts(V value);
  Future<V> getQuickSearchAmounts();
}

abstract interface class SavedFoods<K, V> {
  Future<void> setSavedFoods(V value);
  Future<V> getSavedFoods();
}
