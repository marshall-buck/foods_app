import 'package:foods_app/common/common.dart';
import 'package:foods_app/external_data/external_data.dart';
import 'package:foods_app/features/food_search/food_search.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

registerDependencies() {
  di.registerSingletonAsync<SharedUserPrefsServiceImp>(() async {
    final SharedPreferencesAsync shared = SharedPreferencesAsync();

    final settings = SharedUserPrefsServiceImp(shared);
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
