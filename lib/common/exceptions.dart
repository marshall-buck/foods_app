class PreferencesNotInitializedException implements Exception {
  final String message;
  PreferencesNotInitializedException(this.message);

  @override
  String toString() => 'PreferencesNotInitializedException: $message';
}
