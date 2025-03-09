import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foods_app/data/data.dart';

import 'package:foods_app/food_search/models/food_list_item_model.dart';

part 'food_search_event.dart';
part 'food_search_state.dart';

class FoodSearchBloc extends Bloc<FoodSearchEvent, FoodSearchState> {
  FoodSearchBloc({
    required LocalFoodsDBRepo localFoodsDBRepo,
    required UserPrefsRepository userPreferences,
    required ActiveFoods activeFoods,
  })  : _localFoodsDBRepo = localFoodsDBRepo,
        _userPreferencesRepository = userPreferences,
        _activeFoods = activeFoods,
        super(const FoodSearchState()) {
    on<FoodSearchTextChanged>(_onTextChanged);
    on<FoodSearchTextCleared>(_onClearText);
    on<FoodSearchListItemSelected>((event, emit) async {
      await _onListItemSelected(event, emit);
    });
    // on<FoodSearchInitialized>((event, emit) async {
    //   await emit.onEach(
    //     _userPreferencesRepository.quickSearchIdsStream,
    //     onData: (quickSearch) {
    //       emit(state.copyWith(quickSearchIds: quickSearch));
    //     },
    //   );
    // });
  }

  final LocalFoodsDBRepo _localFoodsDBRepo;
  final UserPrefsRepository _userPreferencesRepository;
  final ActiveFoods _activeFoods;

  // Future<void> _onQuickSearchPrefsChange(
  //   Emitter<FoodSearchState> emit,
  //   List<String> quickSearch,
  // ) async {
  //   emit(state.copyWith(quickSearchIds: quickSearch));
  //   final oldFoods = state.foods;
  // }

  Future<void> _onListItemSelected(FoodSearchListItemSelected event, Emitter<FoodSearchState> emit) async {
    final food = await _localFoodsDBRepo.queryFood(id: event.id);
    assert(food != null, 'Food not found in _onListItemSelected, in FoodSearchBloc');
    _activeFoods.addFood(food!);
  }

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
      final results = await _localFoodsDBRepo.queryFoods(searchTerm: string);
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

  @override
  void onEvent(FoodSearchEvent event) {
    super.onEvent(event);
    log('FoodSearchBloc onEvent $event');
  }

  // @override
  // void onChange(Change<FoodSearchState> change) {
  //   super.onChange(change);
  //   log('onChange $change');
  // }

  // @override
  // void onTransition(
  //   Transition<FoodSearchEvent, FoodSearchState> transition,
  // ) {
  //   super.onTransition(transition);
  //   log('onTransition $transition');
  // }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    log('onError $error');
  }
}
