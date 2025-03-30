part of 'food_search_bloc.dart';

/// {@template food_search_event}
/// Base class for all food search events.
/// {@endtemplate}
sealed class FoodSearchEvent extends Equatable {
  /// {@macro food_search_event}
  const FoodSearchEvent();

  @override
  List<Object?> get props => [];
}

/// {@template food_search_initialized}
/// Event triggered to initialize the food search feature.
/// {@endtemplate}
final class FoodSearchInitialized extends FoodSearchEvent {
  /// {@macro food_search_initialized}
  const FoodSearchInitialized();
}

/// {@template food_search_ended}
/// Event triggered to indicate the end of the food search process.
/// {@endtemplate}
final class FoodSearchEnded extends FoodSearchEvent {
  /// {@macro food_search_ended}
  const FoodSearchEnded();
}

/// {@template food_search_list_item_selected}
/// Event triggered when a food item is selected from the search results.
/// {@endtemplate}
final class FoodSearchListItemSelected extends FoodSearchEvent {
  /// {@macro food_search_list_item_selected}
  const FoodSearchListItemSelected(this.id);

  /// The ID of the selected food item.
  final int id;

  @override
  List<Object?> get props => [id];
}

/// {@template food_search_text_cleared}
/// Event triggered when the search text is cleared.
/// {@endtemplate}
final class FoodSearchTextCleared extends FoodSearchEvent {}

/// {@template food_search_text_changed}
/// Event triggered when the search text changes.
/// {@endtemplate}
final class FoodSearchTextChanged extends FoodSearchEvent {
  /// {@macro food_search_text_changed}
  const FoodSearchTextChanged({required this.searchTerm});

  /// The updated search term.
  final String searchTerm;

  @override
  List<Object> get props => [searchTerm];

  @override
  String toString() => 'TextChanged { text: $searchTerm }';
}
