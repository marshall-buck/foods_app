class PreferencesNotInitialized implements Exception {
  PreferencesNotInitialized(this.message);
  final String message;

  @override
  String toString() => 'PreferencesNotInitializedException: $message';
}
