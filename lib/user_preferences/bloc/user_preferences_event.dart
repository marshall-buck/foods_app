part of 'user_preferences_bloc.dart';

sealed class UserPreferencesEvent extends Equatable {
  const UserPreferencesEvent();
  @override
  List<Object> get props => [];
}

final class UserPreferencesInitialized extends UserPreferencesEvent {
  const UserPreferencesInitialized();
}

final class UserPreferencesDisplayModeError extends UserPreferencesEvent {
  const UserPreferencesDisplayModeError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class UserPreferencesDisplayModeChanged extends UserPreferencesEvent {
  const UserPreferencesDisplayModeChanged(this.displayMode);

  final String displayMode;

  @override
  List<Object> get props => [displayMode];
}

final class UserPreferencesQuickSearchChanged extends UserPreferencesEvent {
  const UserPreferencesQuickSearchChanged(this.quickSearch);

  final List<String> quickSearch;

  @override
  List<Object> get props => [quickSearch];
}

final class UserPreferencesSavedFoodsChanged extends UserPreferencesEvent {
  const UserPreferencesSavedFoodsChanged(this.savedFoods);

  final List<String> savedFoods;

  @override
  List<Object> get props => [savedFoods];
}

final class UserPreferencesSavedFoodsCleared extends UserPreferencesEvent {
  const UserPreferencesSavedFoodsCleared();
}
