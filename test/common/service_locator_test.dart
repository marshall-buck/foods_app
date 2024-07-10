import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/common/service_locator.dart';
import 'package:foods_app/food_search/managers/food_search_manager.dart';
import 'package:foods_app/services/services_B.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

import '../setup/setup.dart';

GetIt? instance;

void main() {
  startUpOnce();
  group('Dependency Registration', () {
    setUp(() async {
      instance = GetIt.asNewInstance();

      instance!.registerSingletonAsync<UserPreferencesService>(() async {
        SharedPreferences.setMockInitialValues({'a': 1});
        final shared = await SharedPreferences.getInstance();
        // await shared.clear();
        final settings = UserPreferencesService(shared);
        await settings.init();
        return settings;
      });

      instance!.registerSingletonAsync<UsdaDB>(() async {
        final db = UsdaDB();
        await db.init();
        return db;
      }, dispose: (x) async => await x.dispose());

      instance!.registerSingleton<FoodsDBInterface>(FoodsDB(),
          instanceName: LocatorName.foodsDBService);

      instance!.registerSingleton<FoodSearchManager>(FoodSearchManager());
    });
    tearDown(() async {
      await instance!.reset();
      instance = null;
    });
    test('allReady should complete without error', () async {
      final usda = await instance!.getAsync<UsdaDB>();
      expect(usda.isDataLoaded, isTrue);

      expect(instance!.allReady(), completes);
    });
    test('UsdaDB singleton should complete and be type UsdaDB', () async {
      final usda = await instance!.getAsync<UsdaDB>();
      expect(usda, isA<UsdaDB>());
    });
    test(
        'UserPreferencesService singleton should complete and be type UserPreferencesService',
        () async {
      final prefs = await instance!.getAsync<UserPreferencesService>();
      expect(prefs, isA<UserPreferencesService>());
    });
    test('FoodsDB singleton should complete and be type FoodsDBInterface', () {
      final foodsDB = instance!
          .get<FoodsDBInterface>(instanceName: LocatorName.foodsDBService);
      expect(foodsDB, isA<FoodsDBInterface>());
    });
    test(
        'FoodSearchManager singleton should complete and be type FoodSearchManager',
        () {
      final search = instance!.get<FoodSearchManager>();
      expect(search, isA<FoodSearchManager>());
    });
  });
}
