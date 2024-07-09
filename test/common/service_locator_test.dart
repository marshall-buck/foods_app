import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/common/service_locator.dart';
import 'package:foods_app/food_search/managers/food_search_manager.dart';
import 'package:foods_app/services/services_B.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

import '../setup/setup.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

GetIt? instance;

void main() {
  startUpOnce();
  group('Dependency Registration', () {
    setUp(() async {
      instance = GetIt.asNewInstance();

      instance!.registerSingletonAsync<UserPreferencesService>(() async {
        SharedPreferences.setMockInitialValues({});
        final shared = await SharedPreferences.getInstance();
        await shared.clear();
        final settings = UserPreferencesService(shared);
        await settings.init();
        return settings;
      });

      instance!.registerSingletonAsync<UsdaDB>(() async {
        final db = UsdaDB();
        await db.init();
        return db;
      }, dispose: (x) async => await x.dispose());

      instance!.registerSingletonWithDependencies<FoodsDBInterface>(
          () => FoodsDB(),
          instanceName: LocatorName.foodsDBService,
          dependsOn: [UsdaDB]);

      instance!.registerSingleton<FoodSearchManager>(FoodSearchManager());
      // di.registerSingletonWithDependencies<FoodSearchManager>(
      //     () => FoodSearchManager(),
      //     dependsOn: [
      //       InitDependency(FoodsDBInterface,
      //           instanceName: LocatorName.foodsDBService)
      //     ]);
    });
    tearDown(() async {
      await instance!.reset();
      instance = null;
    });
    test('registerDependencies should register all dependencies without errors',
        () async {
      // Verify that all dependencies are registered
      expect(instance!.allReady(), completes);
    });
  });
}
