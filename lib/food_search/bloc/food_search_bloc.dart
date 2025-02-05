import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foods_app/data/data.dart';
import 'package:foods_app/food_search/models/food_list_item_model.dart';

part 'food_search_event.dart';
part 'food_search_state.dart';

class FoodSearchBloc extends Bloc<FoodSearchEvent, FoodSearchState> {
  FoodSearchBloc({
    required FoodsDBRepository foodsDBRepo,
    required LocalUserPrefsRepo userPreferences,
  })  : _foodsDBRepo = foodsDBRepo,
        _userPreferences = userPreferences,
        super(FoodSearchEmptyState()) {
    on<TextChanged>(_onTextChanged);
  }

  final FoodsDBRepository _foodsDBRepo;
  final LocalUserPrefsRepo _userPreferences;

  Future<void> _onTextChanged(
    TextChanged event,
    Emitter<FoodSearchState> emit,
  ) async {
    final searchTerm = event.searchTerm;

    if (searchTerm.isEmpty) return emit(FoodSearchEmptyState());
    try {
      final foodsList = await _queryFoods(searchTerm);
      if (foodsList.isEmpty) {
        emit(FoodSearchEmptyState());
      } else {
        emit(FoodSearchSuccessState(foodsList as Iterable<FoodListItemModel>));
      }
    } catch (e) {
      log(
        'Error in _onTextChanged',
        name: 'FoodSearchBloc',
        error: e,
        stackTrace: StackTrace.current,
      );
      emit(const FoodsSearchErrorState('Error searching for foods'));
    }
  }

  Future<Iterable<FoodListItemModel?>> _queryFoods(
    String string,
  ) async {
    try {
      final foods = await _foodsDBRepo.queryFoods(searchTerm: string);

      if (foods.isNotEmpty) {
        final newItems = <FoodListItemModel>[];
        for (final food in foods) {
          final foodItem = await FoodListItemModel.fromFoodDTO(
            food!,
            _userPreferences,
          );
          newItems.add(foodItem);
        }

        return newItems;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
