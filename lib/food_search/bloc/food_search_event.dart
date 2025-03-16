part of 'food_search_bloc.dart';

sealed class FoodSearchEvent extends Equatable {
  const FoodSearchEvent();

  @override
  List<Object?> get props => [];
}

final class FoodSearchInitialized extends FoodSearchEvent {
  const FoodSearchInitialized();
}

final class FoodSearchEnded extends FoodSearchEvent {
  const FoodSearchEnded();
}

final class FoodSearchListItemSelected extends FoodSearchEvent {
  const FoodSearchListItemSelected(this.id);
  final int id;

  @override
  List<Object?> get props => [id];
}

final class FoodSearchTextCleared extends FoodSearchEvent {}

final class FoodSearchTextChanged extends FoodSearchEvent {
  const FoodSearchTextChanged({required this.searchTerm});

  final String searchTerm;

  @override
  List<Object> get props => [searchTerm];

  @override
  String toString() => 'TextChanged { text: $searchTerm }';
}
