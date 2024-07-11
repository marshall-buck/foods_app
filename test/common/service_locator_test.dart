import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/common/service_locator.dart';
import 'package:foods_app/features/food_search/managers/food_search_manager.dart';
import 'package:foods_app/external_data/external_services_B.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

import '../setup/setup.dart';

void main() {
  startUpOnce();
  setUp(() async {
    instance = GetIt.asNewInstance();

    instance!.registerSingletonAsync<UserPreferencesService>(() async {
      SharedPreferences.setMockInitialValues({'a': 1});
      final shared = await SharedPreferences.getInstance();

      final settings = UserPreferencesService(shared);
      await settings.init();
      return settings;
    });

    instance!.registerSingletonAsync<FoodsDBInterface>(() async {
      final UsdaDB usdaDB = UsdaDB();
      await usdaDB.init();
      return FoodsDB(usdaDB);
    },
        instanceName: LocatorName.foodsDBService,
        dispose: (x) async => await x.dispose());

    instance!.registerSingleton<FoodSearchManager>(FoodSearchManager());

    return Future(() => null);
  });
  tearDown(() async {
    await instance!.reset();

    return Future(() => null);
  });

  group('Dependency Registration', () {
    test('allReady should complete without error', () async {
      expect(instance!.allReady(), completes);
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
