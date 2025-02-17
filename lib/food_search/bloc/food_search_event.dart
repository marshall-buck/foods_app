part of 'food_search_bloc.dart';

sealed class FoodSearchEvent extends Equatable {
  const FoodSearchEvent();

  @override
  List<Object> get props => [];
}

final class FoodSearchInitialized extends FoodSearchEvent {}

final class FoodSearchTextCleared extends FoodSearchEvent {}

final class FoodSearchTextChanged extends FoodSearchEvent {
  const FoodSearchTextChanged({required this.searchTerm});

  final String searchTerm;

  @override
  List<Object> get props => [searchTerm];

  @override
  String toString() => 'TextChanged { text: $searchTerm }';
}

final class FoodSearchEnded extends FoodSearchEvent {}
