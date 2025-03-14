part of 'food_search_bloc.dart';

enum FoodSearchStatus { initiated, ended, success, error }

final class FoodSearchState extends Equatable {
  const FoodSearchState({
    this.status = FoodSearchStatus.initiated,
    this.foods = const [],
    this.quickSearchIds = const [],
    this.error = '',
  });

  final FoodSearchStatus status;
  final List<FoodListItemModel?> foods;
  final List<String> quickSearchIds;
  final String error;

  List<String> get quickSearchNames => _createQuickSearchNames();

  bool get hasResults => foods.isNotEmpty;

  List<String> _createQuickSearchNames() {
    return quickSearchIds
        .map((id) {
          return NutrientDTO.originalNutrientTableEdit[int.parse(id)]!['name']!;
        })
        .toList()
        .reversed
        .toList();
  }

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
