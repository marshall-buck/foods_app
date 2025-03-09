part of 'food_detail_bloc.dart';

enum FoodDetailStatus { success, error }

final class FoodDetailState extends Equatable {
  const FoodDetailState({this.status, this.foods, this.allNutrientIdsInQ, this.modifier = 1});
  final FoodDetailStatus? status;
  final Queue<Food?>? foods;
  final Set<int?>? allNutrientIdsInQ;

  final double modifier;

  FoodDetailState copyWith({
    FoodDetailStatus? status,
    Queue<Food?>? foods,
    Set<int?>? allNutrientIdsInQ,
    double? modifier,
  }) {
    return FoodDetailState(
      status: status ?? this.status,
      foods: foods ?? this.foods,
      allNutrientIdsInQ: allNutrientIdsInQ ?? this.allNutrientIdsInQ,
      modifier: modifier ?? this.modifier,
    );
  }

  List<Food?>? get foodsList => foods?.toList();

  List<int> get foodIds => foods!.map((food) => food!.id).toList();

  @override
  List<Object?> get props => [status, foods, allNutrientIdsInQ];
}
