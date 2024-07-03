import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/constants.dart';
import 'package:foods_app/data/interfaces/foods_db_interface.dart';
import 'package:foods_app/data/services/db_service.dart';

import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

import '../../setup/setup.dart';

// import '../../setup/setup_tests.dart';

void main() {
  startUpOnce();
  group('FoodsDBService class tests', () {
    group('queryFood', () {
      test('calls method from usdaDB', () async {
        await di.reset();
        di.registerSingletonAsync<UsdaDB>(() async => await UsdaDB.init());
        di.registerSingleton<FoodsDBInterface>(FoodsDBService(),
            instanceName: ServiceInstance.foodsDBService.string,
            signalsReady: true);
        final usdaDB = await di.getAsync<UsdaDB>();
        final db = di.get<FoodsDBInterface>(
            instanceName: ServiceInstance.foodsDBService.string);

        expect(usdaDB.isDataLoaded, isTrue);
        expect(db, isA<FoodsDBInterface>());

        expect(() async => await db.queryFood(id: 00000000), returnsNormally);
      });
    });
  });
}
