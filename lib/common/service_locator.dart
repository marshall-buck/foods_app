import 'package:foods_app/features/food_search/managers/food_search_manager.dart';
import 'package:foods_app/external_data/external_services_B.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

class LocatorName {
  static const String foodsDBService = 'foodsDBService';
  static const String externalDBService = 'externalDBService';
}

registerDependencies() {
  di.registerSingletonAsync<UserPreferencesService>(() async {
    final shared = await SharedPreferences.getInstance();

    final settings = UserPreferencesService(shared);
    await settings.init();
    return settings;
  });

  di.registerSingletonAsync<FoodsDBInterface>(() async {
    final UsdaDB usdaDB = UsdaDB();
    await usdaDB.init();
    return FoodsDB(usdaDB);
  },
      instanceName: LocatorName.foodsDBService,
      dispose: (x) async => await x.dispose());

  di.registerSingleton<FoodSearchManager>(FoodSearchManager());
}