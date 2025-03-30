/// {@template preferences_not_initialized}
/// An exception that is thrown when preferences are accessed before being initialized.
///
/// This exception is typically used to indicate that an operation requiring
/// initialized preferences cannot proceed because the preferences have not
/// been properly set up.
/// {@endtemplate}
class PreferencesNotInitialized implements Exception {
  /// {@macro preferences_not_initialized}
  PreferencesNotInitialized(this.message);

  /// A message describing the details of the exception.
  final String message;

  @override
  String toString() => 'PreferencesNotInitializedException: $message';
}
