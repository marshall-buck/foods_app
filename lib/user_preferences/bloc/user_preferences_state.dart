part of 'user_preferences_bloc.dart';

class UserPreferencesState extends Equatable {
  const UserPreferencesState({
    required this.displayMode,
    required this.quickSearchIds,
    required this.savedFoods,
  });

  factory UserPreferencesState.empty() {
    return const UserPreferencesState(
      displayMode: '',
      quickSearchIds: [],
      savedFoods: [],
    );
  }

  final String displayMode;
  final List<String> quickSearchIds;
  final List<String> savedFoods;

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
