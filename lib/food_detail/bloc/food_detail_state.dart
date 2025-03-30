part of 'food_detail_bloc.dart';

enum FoodDetailStatus { success, error }

/// {@template food_detail_state}
/// Represents the state of the FoodDetailBloc, including the status,
/// active foods, nutrient IDs, and the modifier value.
/// {@endtemplate}
final class FoodDetailState extends Equatable {
  /// {@macro food_detail_state}
  const FoodDetailState({
    this.status,
    this.foods,
    this.allNutrientIdsInQ,
    this.modifier = 1,
  });

  /// The current status of the food detail operation.
  final FoodDetailStatus? status;

  /// The queue of active foods being managed.
  final Queue<Food?>? foods;

  /// A set of all nutrient IDs present in the active food queue.
  final Set<int?>? allNutrientIdsInQ;

  /// The modifier value applied to amounts.
  final double modifier;

  /// Creates a copy of the current state with updated properties.
  ///
  /// [status] - The new status of the operation.
  /// [foods] - The updated queue of active foods.
  /// [allNutrientIdsInQ] - The updated [Set] of nutrient IDs.
  /// [modifier] - The updated modifier value.
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

  /// Converts the queue of foods into a list.
  List<Food?> get foodsList => foods?.toList() ?? [];

  /// Retrieves the IDs of all foods in the queue.
  List<int> get foodIds => foods!.map((food) => food!.id).toList();

  /// Retrieves the name of a nutrient by its ID.
  ///
  /// [id] - The ID of the nutrient.
  /// Returns the name of the nutrient or an empty string if not found.
  String getNutrientNameById(int id) => NutrientDTO.usdaDBNutrientLookupTable[id]?['name'] ?? '';

  @override
  List<Object?> get props => [status, foods, allNutrientIdsInQ, modifier];
}
