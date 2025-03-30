part of 'food_detail_bloc.dart';

/// {@template food_detail_event}
/// Represents an event in the Food Detail feature.
///
/// Events are used to trigger state changes in the [FoodDetailBloc].
/// {@endtemplate}
sealed class FoodDetailEvent extends Equatable {
  /// {@macro food_detail_event}
  const FoodDetailEvent();

  @override
  List<Object> get props => [];
}

/// {@template fetch_food_detail_event}
/// Event to fetch food details.
///
/// This event triggers the loading of active foods and their associated data.
/// {@endtemplate}
final class FetchFoodDetailEvent extends FoodDetailEvent {}

/// {@template modify_amount_food_detail_event}
/// Event to modify the amount of food.
///
/// This event updates the modifier value in the state.
/// {@endtemplate}
final class ModifyAmountFoodDetailEvent extends FoodDetailEvent {
  /// {@macro modify_amount_food_detail_event}
  const ModifyAmountFoodDetailEvent();
}
