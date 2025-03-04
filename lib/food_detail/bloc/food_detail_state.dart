part of 'food_detail_bloc.dart';

enum FoodDetailStatus { success, error }

final class FoodDetailState extends Equatable {
  const FoodDetailState({this.status, this.foods, this.amountIdsSet});
  final FoodDetailStatus? status;
  final Queue<Food?>? foods;
  final Set<int?>? amountIdsSet;

  FoodDetailState copyWith({FoodDetailStatus? status, Queue<Food?>? foods, Set<int?>? amountIdsSet}) {
    return FoodDetailState(
      status: status ?? this.status,
      foods: foods ?? this.foods,
      amountIdsSet: amountIdsSet ?? this.amountIdsSet,
    );
  }

  List<Food?>? get foodsList => foods?.toList();

  @override
  List<Object?> get props => [status, foods, amountIdsSet];
}
