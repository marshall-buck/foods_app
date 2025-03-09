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
    // on<ChangeUnitFoodDetailEvent>(_changeUnits);
  }

  final ActiveFoods _activeFoods;
  final LocalFoodsDBRepo _localFoodsDBRepo;
  static const circularRangeFinderPercentChange = .05;

  FoodDetailState _onActiveFoodsData(Queue<Food?> foods) {
    final allNutrientIdsInQ = foods.expand((food) => food!.amountMap.keys.where((key) => key <= 9999)).toSet();
    // log('allNutrientIdsInQ: $allNutrientIdsInQ');
    return state.copyWith(
      foods: foods,
      status: FoodDetailStatus.success,
      allNutrientIdsInQ: allNutrientIdsInQ,
      modifier: _activeFoods.activeModifier,
    );
  }

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
