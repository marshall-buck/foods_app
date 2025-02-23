import 'dart:collection';

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
        onData: (Queue<Food?> foods) => FoodDetailState(foods: foods, status: FoodDetailStatus.success),
      );
    });
    on<AddFoodDetailEvent>(_onAddFoodDetail);
  }

  final ActiveFoods _activeFoods;
  final LocalFoodsDBRepo _localFoodsDBRepo;

  Future<void> _onAddFoodDetail(AddFoodDetailEvent event, Emitter<FoodDetailState> emit) async {
    try {
      final food = await _localFoodsDBRepo.queryFood(id: event.id);
      print(food);
      _activeFoods.add(food!);
      emit(state.copyWith(foods: _activeFoods.activeFoods, status: FoodDetailStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FoodDetailStatus.error));
      print(e);
    }
  }
}
