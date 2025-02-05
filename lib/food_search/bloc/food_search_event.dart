part of 'food_search_bloc.dart';

sealed class FoodSearchEvent extends Equatable {
  const FoodSearchEvent();

  @override
  List<Object> get props => [];
}

class TextChanged extends FoodSearchEvent {
  const TextChanged({required this.searchTerm});

  final String searchTerm;

  @override
  List<Object> get props => [searchTerm];

  @override
  String toString() => 'TextChanged { text: $searchTerm }';
}
