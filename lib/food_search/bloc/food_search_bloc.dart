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
    required UserPrefsRepository userPreferences,
  })  : _foodsDBRepo = foodsDBRepo,
        _userPreferences = userPreferences,
        super(const FoodSearchInitialState()) {
    on<TextChanged>(_onTextChanged);
  }

  final FoodsDBRepository _foodsDBRepo;
  final UserPrefsRepository _userPreferences;

  Future<void> _onTextChanged(
    TextChanged event,
    Emitter<FoodSearchState> emit,
  ) async {
    final searchTerm = event.searchTerm;

    if (searchTerm.isEmpty) return emit(const FoodSearchEmptyState());
    try {
      final foodsList = await _queryFoods(searchTerm);
      if (foodsList.isEmpty) {
        emit(const FoodSearchEmptyState());
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
        final foodListItems = <FoodListItemModel>[];
        for (final food in foods) {
          final nutrientAmounts = await _createNutrientQuickSearchAmounts(
            food!,
            _userPreferences.quickSearchIds,
          );
          final foodItem = await FoodListItemModel.fromFoodDTO(
            food: food,
            nutrientAmounts: nutrientAmounts,
          );

          foodListItems.add(foodItem);
        }

        return foodListItems;
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _getNames() async {
    try {
      final quick = _userPreferences.quickSearchIds;
      final names = quick
          .map((id) {
            return NutrientDAO
                .originalNutrientTableEdit[int.parse(id)]!['name']!;
          })
          .toList()
          .reversed
          .toList();
    } catch (e) {
      log(
        'error',
        time: DateTime.now(),
        name: 'QuickSearchManager.getNames()',
        error: e,
      );
    }
  }

  // Returns a list of nutrient amounts for the food, based on the user's
  // quick search preferences.
  Future<List<String>> _createNutrientQuickSearchAmounts(
    FoodDAO food,
    List<String> quickSearchIds,
  ) async {
    final nutrients = food.nutrients;
    final matches = <String>[];
    for (final string in quickSearchIds) {
      final id = int.parse(string);

      if (nutrients.containsKey(id)) {
        matches.add(nutrients[id].toString());
      } else {
        matches.add('0');
      }
    }

    return matches.reversed.toList();
  }
}
