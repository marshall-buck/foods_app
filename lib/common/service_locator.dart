import 'package:foods_app/food_search/managers/food_search_manager.dart';
import 'package:foods_app/services/services_B.dart';
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

  di.registerSingletonAsync<UsdaDB>(() async {
    final db = UsdaDB();
    await db.init();
    return db;
  }, dispose: (x) async => await x.dispose());

  di.registerSingletonWithDependencies<FoodsDBInterface>(() => FoodsDB(),
      instanceName: LocatorName.foodsDBService, dependsOn: [UsdaDB]);

  di.registerSingleton<FoodSearchManager>(FoodSearchManager());
  // di.registerSingletonWithDependencies<FoodSearchManager>(
  //     () => FoodSearchManager(),
  //     dependsOn: [
  //       InitDependency(FoodsDBInterface,
  //           instanceName: LocatorName.foodsDBService)
  //     ]);
}
