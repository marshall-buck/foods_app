import 'package:flutter_test/flutter_test.dart';

import 'package:foods_app/common/service_locator.dart';
import 'package:foods_app/services/services_B.dart';

import 'package:usda_db_package/usda_db_package.dart';

import '../../setup/setup.dart';

void main() {
  startUpOnce();
  group('FoodsDBService class tests', () {
    group('queryFood', () {
      test('calls method from usdaDB', () async {
        await testingInstance.reset();
        testingInstance.registerSingletonAsync<UsdaDB>(() async {
          final db = UsdaDB();
          await db.init();
          return db;
        }, dispose: (x) async => await x.dispose());
        testingInstance.registerSingletonWithDependencies<FoodsDBInterface>(
            () => FoodsDB(),
            instanceName: LocatorName.foodsDBService,
            dependsOn: [UsdaDB]);
        await testingInstance.allReady();
        final usdaDB = await testingInstance.getAsync<UsdaDB>();
        final db = await testingInstance.get<FoodsDBInterface>(
            instanceName: LocatorName.foodsDBService);

        expect(usdaDB.isDataLoaded, isTrue);
        expect(db, isA<FoodsDBInterface>());

        expect(() async => await db.queryFood(id: 00000000), returnsNormally);
        final food = await db.queryFood(id: 167512);
        expect(food, isA<FoodModel>());
      });
    });
  });
}
