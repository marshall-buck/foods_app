part of 'food_search_bloc.dart';

/// {@template food_search_status}
/// Represents the various statuses of the food search process.
/// {@endtemplate}
enum FoodSearchStatus {
  /// The search process has been initiated.
  initiated,

  /// The search process has ended.
  ended,

  /// The search process completed successfully.
  success,

  /// An error occurred during the search process.
  error
}

/// {@template food_search_state}
/// Represents the state of the food search feature.
/// {@endtemplate}
final class FoodSearchState extends Equatable {
  /// {@macro food_search_state}
  const FoodSearchState({
    this.status = FoodSearchStatus.initiated,
    this.foods = const [],
    this.quickSearchIds = const [],
    this.error = '',
  });

  /// {@macro food_search_status}
  final FoodSearchStatus status;

  /// A list of ui models resulting from the search.
  final List<FoodListItemModel?> foods;

  /// A list of quick search IDs from preferences.
  final List<String> quickSearchIds;

  /// An error message, if any, encountered during the search process.
  final String error;

  /// Returns the names corresponding to the quick search IDs.
  List<String> get quickSearchNames => _createQuickSearchNames();

  /// Indicates whether the search has results.
  bool get hasResults => foods.isNotEmpty;

  /// Creates a list of quick search names based on the quick search IDs.
  List<String> _createQuickSearchNames() {
    return quickSearchIds
        .map((id) {
          return NutrientDTO.originalNutrientTableEdit[int.parse(id)]!['name']!;
        })
        .toList()
        .reversed
        .toList();
  }

  /// Creates a copy of the current state with updated properties.
  ///
  /// If a property is not provided, the current value is retained.
  FoodSearchState copyWith({
    FoodSearchStatus? status,
    List<FoodListItemModel?>? foods,
    List<String>? quickSearchIds,
    String? error,
  }) {
    return FoodSearchState(
      status: status ?? this.status,
      foods: foods ?? this.foods,
      quickSearchIds: quickSearchIds ?? this.quickSearchIds,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, foods, quickSearchIds, error];
}
