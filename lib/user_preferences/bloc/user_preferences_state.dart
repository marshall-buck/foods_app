part of 'user_preferences_bloc.dart';

/// {@template user_preferences_state}
/// A state that holds user preferences such as display mode, quick search IDs, and saved foods.
/// {@endtemplate}
class UserPreferencesState extends Equatable {
  /// {@macro user_preferences_state}
  const UserPreferencesState({
    required this.displayMode,
    required this.quickSearchIds,
    required this.savedFoods,
  });

  /// Creates an empty [UserPreferencesState].
  factory UserPreferencesState.empty() {
    return const UserPreferencesState(
      displayMode: '',
      quickSearchIds: [],
      savedFoods: [],
    );
  }

  /// The display mode preference of the user.
  final String displayMode;

  /// A list of quick search IDs saved by the user.
  final List<String> quickSearchIds;

  /// A list of foods saved by the user.
  final List<String> savedFoods;

  /// Creates a copy of the current state with optional new values.
  UserPreferencesState copyWith({
    String? displayMode,
    List<String>? quickSearchIds,
    List<String>? savedFoods,
  }) {
    return UserPreferencesState(
      displayMode: displayMode ?? this.displayMode,
      quickSearchIds: quickSearchIds ?? this.quickSearchIds,
      savedFoods: savedFoods ?? this.savedFoods,
    );
  }

  @override
  List<Object> get props => [displayMode, quickSearchIds, savedFoods];
}
