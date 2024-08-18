import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/common/service_locator.dart';
import 'package:foods_app/external_data/external_data.dart';
import 'package:foods_app/features/food_search/managers/food_search_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

import '../setup/setup.dart';

void main() {
  startUpOnce();
  setUp(() async {
    instance = GetIt.asNewInstance();

    instance!.registerSingletonAsync<UserPreferencesServiceI>(() async {
      SharedPreferences.setMockInitialValues({'a': 1});
      final shared = await SharedPreferences.getInstance();

      final settings = UserPreferencesServiceI(shared);
      await settings.init();
      return settings;
    });

    instance!.registerSingletonAsync<FoodsDB>(() async {
      final UsdaDB usdaDB = UsdaDB();
      await usdaDB.init();
      return FoodsDBService(usdaDB);
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
      final prefs = await instance!.getAsync<UserPreferencesServiceI>();
      expect(prefs, isA<UserPreferencesServiceI>());
    });
    test('FoodsDB singleton should complete and be type FoodsDBInterface', () {
      final foodsDB =
          instance!.get<FoodsDB>(instanceName: LocatorName.foodsDBService);

      expect(foodsDB, isA<FoodsDB>());
    });
    test(
        'FoodSearchManager singleton should complete and be type FoodSearchManager',
        () {
      final search = instance!.get<FoodSearchManager>();
      expect(search, isA<FoodSearchManager>());
    });
  });
}
