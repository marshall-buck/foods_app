class PreferencesNotInitializedException implements Exception {
  PreferencesNotInitializedException(this.message);
  final String message;

  @override
  String toString() => 'PreferencesNotInitializedException: $message';
}
