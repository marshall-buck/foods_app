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
    required LocalFoodsDBRepo localFoodsDBRepo,
  })  : _activeFoods = activeFoods,
        _localFoodsDBRepo = localFoodsDBRepo,
        super(const FoodDetailState()) {
    /// Listens for the [FetchFoodDetailEvent] to update the state with active foods and modifiers.
    on<FetchFoodDetailEvent>((event, emit) async {
      await emit.forEach(
        _activeFoods.activeFoodsStream,
        onData: _onActiveFoodsDataChange,
      );
    });

    /// Handles the [AddFoodDetailEvent] to add a food to the active foods queue.
    on<AddFoodDetailEvent>(_onAddFoodDetail);
    on<ModifyAmountFoodDetailEvent>(
      (event, emit) async {
        await emit.forEach(
          _activeFoods.activeModifierStream,
          onData: (data) => state.copyWith(modifier: data),
        );
      },
    );
  }

  final ActiveFoods _activeFoods;
  final LocalFoodsDBRepo _localFoodsDBRepo;

  /// Handles the [ModifyAmountFoodDetailEvent] to change the active modifier.
  // void _changeModifier(ModifyAmountFoodDetailEvent event, Emitter<FoodDetailState> emit) {
  //   // log('changeModifier: ${event.modifier}');
  //   _activeFoods.changeModifier(event.modifier);
  //   // emit(state.copyWith(modifier: _activeFoods.activeModifier));
  // }

  /// The percentage change used for circular range finder adjustments.
  // static const circularRangeFinderPercentChange = .05;

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
      // modifier: _activeFoods.activeModifier,
    );
  }

  /// Handles the [AddFoodDetailEvent].
  ///
  /// [AddFoodDetailEvent] contains the ID of the food to be added.
  Future<void> _onAddFoodDetail(AddFoodDetailEvent event, Emitter<FoodDetailState> emit) async {
    try {
      final food = await _localFoodsDBRepo.queryFood(id: event.id);
      print(food);
      _activeFoods.addFood(food!);
    } catch (e) {
      emit(state.copyWith(status: FoodDetailStatus.error));
      print(e);
    }
  }

  // double _adjustAmountModifier(double amount) {
  //   if (amount >= 50) {
  //     return circularRangeFinderPercentChange * 2;
  //   } else if (amount >= 10) {
  //     return circularRangeFinderPercentChange * 2.1;
  //   } else if (amount >= 1) {
  //     return circularRangeFinderPercentChange * 2.3;
  //   } else {
  //     return circularRangeFinderPercentChange * 2.5;
  //   }
  // }

  // void _changeUnits(ChangeUnitFoodDetailEvent event, Emitter<FoodDetailState> emit) {
  //   final newMap = <int, AmountRecord>{};
  //   final currentItem = state[id]?.$1;
  //   for (final en in state.amountRecords!) {
  //     final key = en.key;
  //     final oldValue = en.value.$1;
  //     final unit = en.value.$3;

  //     final amountModifier = _adjustAmountModifier(currentItem!);

  //     // (amountModifier / 100) calculates a percentage based on the amountModifier.
  //     // Adding/Subtracting 1 to this percentage and multiplying it by the oldValue
  //     // effectively increases/decreases the oldValue by the specified percentage.
  //     final newValue = add ? oldValue * (1 + (amountModifier / 100)) : oldValue * (1 - (amountModifier / 100));

  //     newMap[key] = (newValue, newValue.convert, unit);
  //   }
  //   _amountStrings = newMap;
  // }
  // void changeUnits({required bool add, required int id}) {
  //   assert(
  //     _amountStrings.isNotEmpty,
  //     'FoodAmountManager: _amountStrings is empty',
  //   );
  //   final newMap = <int, AmountRecord>{};
  //   final currentItem = _amountStrings[id]?.$1;
  //   for (final en in _amountStrings.entries) {
  //     final key = en.key;
  //     final oldValue = en.value.$1;
  //     final unit = en.value.$3;

  //     final amountModifier = _adjustAmountModifier(currentItem!);

  //     // (amountModifier / 100) calculates a percentage based on the amountModifier.
  //     // Adding/Subtracting 1 to this percentage and multiplying it by the oldValue
  //     // effectively increases/decreases the oldValue by the specified percentage.
  //     final newValue = add ? oldValue * (1 + (amountModifier / 100)) : oldValue * (1 - (amountModifier / 100));

  //     newMap[key] = (newValue, newValue.convert, unit);
  //   }
  //   _amountStrings = newMap;
  // }

  @override
  void onEvent(FoodDetailEvent event) {
    super.onEvent(event);
    log('FoodSearchBloc onEvent $event');
  }

  @override
  void onChange(Change<FoodDetailState> change) {
    super.onChange(change);
    log('FoodDetailBloc onChange: ${state.modifier}');
  }

  @override
  void onTransition(
    Transition<FoodDetailEvent, FoodDetailState> transition,
  ) {
    super.onTransition(transition);
    log('FoodDetailBloc onTransition: ${transition.currentState.modifier} -> ${transition.nextState.modifier}');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    log('FoodDetailBloc onError $error');
  }
}
