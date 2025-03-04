import 'dart:collection';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foods_app/data/data.dart';
import 'package:foods_app/domain/domain.dart';

part 'food_detail_event.dart';
part 'food_detail_state.dart';

class FoodDetailBloc extends Bloc<FoodDetailEvent, FoodDetailState> {
  FoodDetailBloc({required ActiveFoods activeFoods, required LocalFoodsDBRepo localFoodsDBRepo})
      : _activeFoods = activeFoods,
        _localFoodsDBRepo = localFoodsDBRepo,
        super(const FoodDetailState()) {
    on<FetchFoodDetailEvent>((event, emit) async {
      await emit.forEach(
        _activeFoods.activeFoodsStream,
        onData: _onActiveFoodsData,
      );
    });
    on<AddFoodDetailEvent>(_onAddFoodDetail);
  }

  final ActiveFoods _activeFoods;
  final LocalFoodsDBRepo _localFoodsDBRepo;

  FoodDetailState _onActiveFoodsData(Queue<Food?> foods) {
    final amountIdsSet = foods.expand((food) => food!.nutrientMap.keys).toSet();
    log('amountIdsSet: $amountIdsSet');
    return state.copyWith(foods: foods, status: FoodDetailStatus.success, amountIdsSet: amountIdsSet);
  }

  Future<void> _onAddFoodDetail(AddFoodDetailEvent event, Emitter<FoodDetailState> emit) async {
    try {
      final food = await _localFoodsDBRepo.queryFood(id: event.id);
      print(food);
      _activeFoods.add(food!);

      // emit(state.copyWith(
      //     foods: _activeFoods.activeFoods, status: FoodDetailStatus.success, amountIdsSet: amountIdsSet));
    } catch (e) {
      emit(state.copyWith(status: FoodDetailStatus.error));
      print(e);
    }
  }

  // Set<int?> createNutrientAmountRecordsSet() => foods!.expand((food) => food!.nutrientMap.keys).toSet();

  @override
  void onEvent(FoodDetailEvent event) {
    super.onEvent(event);
    log('FoodSearchBloc onEvent $event');
  }

  @override
  void onChange(Change<FoodDetailState> change) {
    super.onChange(change);
    log('FoodDetailBloc onChange $change');
  }

  @override
  void onTransition(
    Transition<FoodDetailEvent, FoodDetailState> transition,
  ) {
    super.onTransition(transition);
    log('FoodDetailBloc onTransition $transition');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    log('FoodDetailBloc onError $error');
  }
}
