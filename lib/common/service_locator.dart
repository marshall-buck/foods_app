import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/food_search/food_search.dart';
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
        final usdaDB = UsdaDB();
        await usdaDB.init();
        assert(usdaDB.isDataLoaded == true, 'usdaDB is not loaded');
        return FoodsDBService(usdaDB);
      },
      instanceName: LocatorName.foodsDBService,
      dispose: (x) async => x.dispose(),
    ); //FoodsDB
}
