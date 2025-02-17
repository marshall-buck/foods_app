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
        _userPreferencesRepository = userPreferences,
        super(const FoodSearchState()) {
    on<FoodSearchTextChanged>(_onTextChanged);
    on<FoodSearchTextCleared>(_onClearText);
    // on<FoodSearchInitialized>((event, emit) async {
    //   await emit.onEach(
    //     _userPreferencesRepository.quickSearchIdsStream,
    //     onData: (quickSearch) {
    //       emit(state.copyWith(quickSearchIds: quickSearch));
    //     },
    //   );
    // });
  }

  final FoodsDBRepository _foodsDBRepo;
  final UserPrefsRepository _userPreferencesRepository;

  // Future<void> _onQuickSearchPrefsChange(
  //   Emitter<FoodSearchState> emit,
  //   List<String> quickSearch,
  // ) async {
  //   emit(state.copyWith(quickSearchIds: quickSearch));
  //   final oldFoods = state.foods;
  // }

  void _onClearText(
    FoodSearchTextCleared event,
    Emitter<FoodSearchState> emit,
  ) =>
      emit(
        state.copyWith(
          foods: const [],
        ),
      );

  Future<void> _onTextChanged(
    FoodSearchTextChanged event,
    Emitter<FoodSearchState> emit,
  ) async {
    final searchTerm = event.searchTerm;

    if (searchTerm.isEmpty) {
      return;
    } else {
      try {
        final results = await _queryFoods(searchTerm);

        if (results == null) {
          emit(
            state.copyWith(
              foods: const [],
              status: FoodSearchStatus.success,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: FoodSearchStatus.success,
              foods: results.$1,
              quickSearchIds: results.$2,
            ),
          );
        }
      } catch (e) {
        log(
          'Error in _onTextChanged',
          name: 'FoodSearchBloc',
          error: e,
          stackTrace: StackTrace.current,
        );
        emit(
          state.copyWith(error: 'Error in _onTextChanged'),
        );
      }
    }
  }

  Future<(List<FoodListItemModel>, List<String>)?> _queryFoods(
    String string,
  ) async {
    final foodListItems = <FoodListItemModel>[];
    try {
      final results = await _foodsDBRepo.queryFoods(searchTerm: string);
      final quickSearchIds = _userPreferencesRepository.currentQuickSearchIds;

      if (results != null) {
        for (final food in results) {
          final nutrientAmounts = await _createNutrientQuickSearchAmounts(
            food,
            quickSearchIds,
          );

          final foodItem = await FoodListItemModel.fromFoodDAO(
            food: food, nutrientAmounts: nutrientAmounts, //nutrientAmounts,
          );

          foodListItems.add(foodItem);
        }
        return (foodListItems, quickSearchIds);
      }
    } catch (e) {
      log(
        'Error in _queryFoods',
        name: 'FoodSearchBloc',
        error: e,
        stackTrace: StackTrace.current,
      );
    }
    return null;
  }

  // Future<void> _getNames() async {
  //   try {
  //     final quick = await _userPreferences.quickSearchIds;
  //     final names = quick
  //         .map((id) {
  //           return NutrientDAO
  //               .originalNutrientTableEdit[int.parse(id)]!['name']!;
  //         })
  //         .toList()
  //         .reversed
  //         .toList();
  //   } catch (e) {
  //     log(
  //       'error',
  //       time: DateTime.now(),
  //       name: 'QuickSearchManager.getNames()',
  //       error: e,
  //     );
  //   }
  // }

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
