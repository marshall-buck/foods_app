part of 'food_detail_bloc.dart';

sealed class FoodDetailState extends Equatable {
  const FoodDetailState();
  
  @override
  List<Object> get props => [];
}

final class FoodDetailInitial extends FoodDetailState {}
