import 'package:flutter_test/flutter_test.dart';

import 'package:foods_app/common/service_locator.dart';
import 'package:foods_app/food_search/managers/food_search_manager.dart';
import 'package:foods_app/services/services_B.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

import '../../setup/setup.dart';

void main() {
  startUpOnce();
  setUp(() async {
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

  group('FoodsDBService class tests', () {
    group('queryFood', () {
      test('calls method from usdaDB', () async {
        await di.allReady();
        final usdaDB = await di.getAsync<UsdaDB>();
        final db =
            di.get<FoodsDBInterface>(instanceName: LocatorName.foodsDBService);

        expect(usdaDB.isDataLoaded, isTrue);
        expect(db, isA<FoodsDBInterface>());

        expect(() async => await db.queryFood(id: 00000000), returnsNormally);
        final food = await db.queryFood(id: 167512);
        expect(food, isA<FoodModel>());
      });
    });
  });
}
