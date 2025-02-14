part of 'food_search_bloc.dart';

sealed class FoodSearchState extends Equatable {
  const FoodSearchState();
  @override
  List<Object> get props => [];
}

final class FoodSearchInitialState extends FoodSearchState {
  const FoodSearchInitialState();

  @override
  List<Object> get props => [];
}

final class FoodSearchEmptyState extends FoodSearchState {
  const FoodSearchEmptyState();

  @override
  List<Object> get props => [];
}

final class FoodSearchSuccessState extends FoodSearchState {
  const FoodSearchSuccessState(this.foods);

  final Iterable<FoodListItemModel> foods;

  @override
  List<Object> get props => [foods];
}

final class FoodsSearchErrorState extends FoodSearchState {
  const FoodsSearchErrorState(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
