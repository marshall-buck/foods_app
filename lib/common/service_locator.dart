import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:foods_app/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

/// Registers all get_it dependencies.
void registerDependencies() {
  di
    ..registerSingleton<FoodSearchManager>(
      FoodSearchManager(),
    ) //FoodSearchManager
    ..registerSingleton<FoodDetailManager>(
      FoodDetailManager(),
    ) //FoodDetailManager

    // ignore: strict_raw_type
    ..registerSingletonAsync<PreferencesService>(
      () async {
        final shared = SharedPreferencesAsync();

        final settings = SharedUserPrefsServiceImp(shared);
        await settings.init();
        return settings;
      },
      instanceName: LocatorName.sharedPrefsService,
    ) //PreferencesService
    ..registerSingletonAsync<FoodsDB>(
      () async {
        // initializes auto_hyphenating_text package,
        await initHyphenation();
        final usdaDB = UsdaDB();
        await usdaDB.init();
        assert(usdaDB.isDataLoaded == true, 'usdaDB is not loaded');
        return FoodsDBService(usdaDB);
      },
      instanceName: LocatorName.foodsDBService,
      dispose: (x) async => x.dispose(),
    )
    ..registerSingletonAsync<QuickSearchManager>(
      () async {
        final manager = QuickSearchManager();
        await manager.init();
        return manager;
      },
      dependsOn: [
        InitDependency(
          PreferencesService,
          instanceName: LocatorName.sharedPrefsService,
        ),
      ],
    );
}
