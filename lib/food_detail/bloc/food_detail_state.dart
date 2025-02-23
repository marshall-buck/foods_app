part of 'food_detail_bloc.dart';

enum FoodDetailStatus { success, error }

final class FoodDetailState extends Equatable {
  const FoodDetailState({this.status, this.foods});
  final FoodDetailStatus? status;
  final Queue<Food?>? foods;

  FoodDetailState copyWith({FoodDetailStatus? status, Queue<Food?>? foods}) {
    return FoodDetailState(
      status: status ?? this.status,
      foods: foods ?? this.foods,
    );
  }

  @override
  List<Object?> get props => [status, foods];
}
