import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:foods_app/services/services.dart';

import 'package:watch_it/watch_it.dart';

import '../setup/setup.dart';

void main() {
  startUpOnce();

  setUp(() async {
    await di.reset();

    getPreferences();
    registerDependencies();
  });

  group('registerDependencies()', () {
    test('FoodSearchManager should be initialized', () async {
      await di.allReady();

      expect(di.isRegistered<FoodSearchManager>(), true);
    });
    test('FoodsDB should be initialized', () async {
      await di.allReady();

      expect(
        di.isRegistered<FoodsDB>(instanceName: LocatorName.foodsDBService),
        true,
      );
    });

    test('SharedPreferences should be initialized', () async {
      // ignore: strict_raw_type
      final prefsService = await di.getAsync<PreferencesService>(
        instanceName: LocatorName.sharedPrefsService,
      );

      expect(prefsService, isNotNull);
    });

    test('UsdaDB should be initialized and data loaded', () async {
      final db = await di.getAsync<FoodsDB>(
        instanceName: LocatorName.foodsDBService,
      );

      expect(db, isNotNull);
    });
  });
}
