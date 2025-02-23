import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:foods_app/data/data.dart';

part 'user_preferences_event.dart';
part 'user_preferences_state.dart';

class UserPreferencesBloc extends Bloc<UserPreferencesEvent, UserPreferencesState> {
  UserPreferencesBloc({
    required UserPrefsRepository userPreferencesRepo,
  })  : _userPreferencesRepository = userPreferencesRepo,
        super(UserPreferencesState.empty()) {
    on<UserPreferencesInitialized>((event, emit) async {
      await emit.onEach(
        _userPreferencesRepository.quickSearchIdsStream,
        onData: (quickSearch) {
          // final names =
          //     _userPreferencesRepository.createQuickSearchNames(quickSearch);
          emit(
            state.copyWith(
              quickSearchIds: quickSearch,
            ),
          );
        },
      );
      // await emit.onEach(
      //   _userPreferencesRepository.savedFoodsStream,
      //   onData: (savedFoods) {
      //     emit(
      //       state.copyWith(
      //         savedFoods: savedFoods,
      //       ),
      //     );
      //   },
      // );
      // await emit.onEach(
      //   _userPreferencesRepository.displayModeStream,
      //   onData: (displayMode) {
      //     emit(
      //       state.copyWith(displayMode: displayMode),
      //     );
      //   },
      // );
    });
  }

  final UserPrefsRepository _userPreferencesRepository;

  // List<String> _createQuickSearchNames(List<String> ids) => ids
  //   ..map((id) {
  //     return NutrientDAO.originalNutrientTableEdit[int.parse(id)]!['name']!;
  //   }).toList().reversed.toList();
}
