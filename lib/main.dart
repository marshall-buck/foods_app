import 'dart:developer';

import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/app.dart';

import 'package:foods_app/data/data.dart';

import 'package:foods_app/food_search/food_search.dart';

import 'package:foods_app/user_preferences/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:usda_db_package/usda_db_package.dart';

//

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };
  // Bloc.observer = const AppBlocObserver();
  final localDbDao = UsdaDbDAO();
  await localDbDao.init();
  final cache = FoodsSearchCache();
  final localDbRepository = LocalFoodsDBRepo(localDbDao: localDbDao, cache: cache);
  final asyncPrefs = SharedPreferencesAsync();
  final userPreferences = UserPrefsRepository(prefPlugin: asyncPrefs);
  await userPreferences.init();
  final activeFoods = ActiveFoods();
  // initializes auto_hyphenating_text package,
  await initHyphenation();

  runApp(
    EntryPoint(
      localDbRepository: localDbRepository,
      userPreferencesRepo: userPreferences,
      activeFoods: activeFoods,
    ),
  );
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({
    required this.localDbRepository,
    required this.userPreferencesRepo,
    required this.activeFoods,
    super.key,
  });
  final LocalFoodsDBRepo localDbRepository;

  final UserPrefsRepository userPreferencesRepo;

  final ActiveFoods activeFoods;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: localDbRepository,
        ),
        RepositoryProvider.value(
          value: userPreferencesRepo,
        ),
        RepositoryProvider.value(
          value: activeFoods,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FoodSearchBloc>(
            lazy: false,
            create: (BuildContext context) => FoodSearchBloc(
              localFoodsDBRepo: localDbRepository,
              userPreferences: userPreferencesRepo,
              activeFoods: activeFoods,
            ),
          ),
          BlocProvider<UserPreferencesBloc>(
            lazy: false,
            create: (BuildContext context) => UserPreferencesBloc(
              userPreferencesRepo: userPreferencesRepo,
            )..add(
                const UserPreferencesInitialized(),
              ),
          ),
        ],
        child: const App(),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({required this.snapshot, super.key});
  final AsyncSnapshot<void> snapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.error_outline,
          // color: Colors.red,
          size: 48,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('Error from LoadingWidget: ${snapshot.error}'),
        ),
      ],
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: SizedBox(
          width: 48,
          height: 48,
          child: Transform.scale(
            scale: 2,
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
