part of 'food_detail_bloc.dart';

sealed class FoodDetailEvent extends Equatable {
  const FoodDetailEvent();

  @override
  List<Object> get props => [];
}

final class FetchFoodDetailEvent extends FoodDetailEvent {}

final class AddFoodDetailEvent extends FoodDetailEvent {
  const AddFoodDetailEvent({required this.id});
  final int id;

  @override
  List<Object> get props => [id];
}
