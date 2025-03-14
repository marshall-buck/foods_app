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
          emit(
            state.copyWith(
              quickSearchIds: quickSearch,
            ),
          );
        },
      );
    });
  }

  final UserPrefsRepository _userPreferencesRepository;
}
