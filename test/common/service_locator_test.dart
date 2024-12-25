import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/domain/domain.dart';

import 'package:foods_app/data/data.dart';
import 'package:foods_app/ui/core/quick_search_manager.dart';
import 'package:foods_app/ui/ui.dart';

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
    test('FoodCompareManager should be initialized', () async {
      await di.allReady();

      expect(di.isRegistered<FoodCompareManager>(), true);
    });

    test('FoodAmountManager should be initialized', () async {
      await di.allReady();

      expect(di.isRegistered<FoodAmountManager>(), true);
    });
    test('PreferencesService should be initialized', () async {
      await di.allReady();
      // ignore: strict_raw_type
      final prefsService = await di.getAsync<PreferencesService>(
        instanceName: LocatorInstanceNames.sharedPrefsService,
      );

      expect(prefsService, isNotNull);
    });
    test('FoodsDB should be initialized', () async {
      await di.allReady();

      expect(
        di.isRegistered<FoodsDB>(
          instanceName: LocatorInstanceNames.foodsDBService,
        ),
        true,
      );
    });

    test('QuickSearchManager should be initialized', () async {
      await di.allReady();
      final quickSearchManager = await di.getAsync<QuickSearchManager>();

      expect(quickSearchManager, isNotNull);
    });
    test('FoodSearchState should be initialized', () async {
      await di.allReady();
      final foodSearchState = di.get<AppHistoryState>();

      expect(foodSearchState, isNotNull);
    });

    test('UsdaDB should be initialized and data loaded', () async {
      await di.allReady();
      final db = await di.getAsync<FoodsDB>(
        instanceName: LocatorInstanceNames.foodsDBService,
      );

      expect(db, isNotNull);
    });
  });
}
