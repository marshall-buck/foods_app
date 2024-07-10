import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/common/service_locator.dart';
import 'package:foods_app/food_search/managers/food_search_manager.dart';
import 'package:foods_app/services/services_B.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

import '../setup/setup.dart';

void main() {
  startUpOnce();
  setUp(() async {
    // instance = GetIt.asNewInstance();

    di.registerSingletonAsync<UserPreferencesService>(() async {
      SharedPreferences.setMockInitialValues({'a': 1});
      final shared = await SharedPreferences.getInstance();
      // await shared.clear();
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

    return Future(() => null);
  });
  tearDown(() async {
    await di.reset();

    return Future(() => null);
  });

  group('Dependency Registration', () {
    test('allReady should complete without error', () async {
      final usda = await di.getAsync<UsdaDB>();
      expect(usda.isDataLoaded, isTrue);

      expect(di.allReady(), completes);
    });
    test('UsdaDB singleton should complete and be type UsdaDB', () async {
      final usda = await di.getAsync<UsdaDB>();
      expect(usda, isA<UsdaDB>());
    });
    test(
        'UserPreferencesService singleton should complete and be type UserPreferencesService',
        () async {
      final prefs = await di.getAsync<UserPreferencesService>();
      expect(prefs, isA<UserPreferencesService>());
    });
    test('FoodsDB singleton should complete and be type FoodsDBInterface', () {
      final foodsDB =
          di.get<FoodsDBInterface>(instanceName: LocatorName.foodsDBService);

      expect(foodsDB, isA<FoodsDBInterface>());
    });
    test(
        'FoodSearchManager singleton should complete and be type FoodSearchManager',
        () {
      final search = di.get<FoodSearchManager>();
      expect(search, isA<FoodSearchManager>());
    });
  });
}
