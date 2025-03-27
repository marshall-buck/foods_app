import 'dart:collection';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foods_app/data/data.dart';
import 'package:foods_app/domain/domain.dart';

part 'food_detail_event.dart';
part 'food_detail_state.dart';

/// {@template food_detail_bloc}
/// A BLoC that manages the state and events for food details.
/// This includes handling active foods, modifiers, and nutrient data.
/// {@endtemplate}
class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  /// {@macro food_detail_bloc}
  FoodDetailBloc({
    required ActiveFoods activeFoods,
    // required LocalFoodsDBRepo localFoodsDBRepo,
  })  : _activeFoods = activeFoods,
        // _localFoodsDBRepo = localFoodsDBRepo,
        super(FoodDetailState(modifier: activeFoods.activeModifier)) {
    /// Listens for the [FetchFoodDetailEvent] to update the state with active foods and modifiers.
    on<FetchFoodDetailEvent>((event, emit) async {
      await emit.forEach(
        _activeFoods.activeFoodsStream,
        onData: _onActiveFoodsDataChange,
      );
    });

    // on<AddFoodDetailEvent>(_onAddFoodDetail);
    on<ModifyAmountFoodDetailEvent>(
      (event, emit) async {
        await emit.forEach(
          _activeFoods.activeModifierStream,
          onData: (_) => state.copyWith(modifier: _activeFoods.activeModifier),
        );
      },
    );
  }

  final ActiveFoods _activeFoods;
  // final LocalFoodsDBRepo _localFoodsDBRepo;

  /// Handles the [FetchFoodDetailEvent].
  ///
  /// [foods] is the queue of active foods.
  FoodDetailState _onActiveFoodsDataChange(Queue<Food?> foods) {
    final allNutrientIdsInQ = foods.expand((food) => food!.amountMap.keys.where((key) => key <= 9999)).toSet();
    // log('allNutrientIdsInQ: $allNutrientIdsInQ');
    return state.copyWith(
      foods: foods,
      status: FoodDetailStatus.success,
      allNutrientIdsInQ: allNutrientIdsInQ,
      modifier: _activeFoods.activeModifier,
    );
  }

  // /// Handles the [AddFoodDetailEvent].
  // ///
  // /// [AddFoodDetailEvent] contains the ID of the food to be added.
  // Future<void> _onAddFoodDetail(AddFoodDetailEvent event, Emitter<FoodDetailState> emit) async {
  //   try {
  //     final food = await _localFoodsDBRepo.queryFood(id: event.id);

  //     _activeFoods.addFood(food!);
  //   } catch (e) {
  //     emit(state.copyWith(status: FoodDetailStatus.error));
  //     // print(e);
  //   }
  // }

  // @override
  // void onEvent(FoodDetailEvent event) {
  //   super.onEvent(event);
  //   log('FoodSearchBloc onEvent $event');
  // }

  // @override
  // void onChange(Change<FoodDetailState> change) {
  //   super.onChange(change);
  //   log('FoodDetailBloc onChange: ${change.currentState.modifier} -> ${change.nextState.modifier}');
  // }

  // @override
  // void onTransition(
  //   Transition<FoodDetailEvent, FoodDetailState> transition,
  // ) {
  //   super.onTransition(transition);
  //   log('FoodDetailBloc onTransition: ${transition.currentState.modifier} -> ${transition.nextState.modifier}');
  // }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   super.onError(error, stackTrace);
  //   log('FoodDetailBloc onError $error');
  // }
}
