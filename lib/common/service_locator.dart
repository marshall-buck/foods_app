import 'package:foods_app/external_data/external_data.dart';
import 'package:foods_app/features/food_search/managers/food_search_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

class LocatorName {
  static const String foodsDBService = 'foodsDBService';
  static const String externalDBService = 'externalDBService';
}

registerDependencies() {
  di.registerSingletonAsync<UserPreferencesServiceI>(() async {
    final SharedPreferencesAsync shared = SharedPreferencesAsync();

    final settings = UserPreferencesServiceI(shared);
    await settings.init();
    return settings;
  });

  di.registerSingletonAsync<FoodsDB>(() async {
    final UsdaDB usdaDB = UsdaDB();
    await usdaDB.init();
    assert(usdaDB.isDataLoaded == true);
    return FoodsDBService(usdaDB);
  },
      instanceName: LocatorName.foodsDBService,
      dispose: (x) async => await x.dispose());

  di.registerSingleton<FoodSearchManager>(FoodSearchManager());
}
