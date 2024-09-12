// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/food_search/food_search.dart';
import 'package:foods_app/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/types.dart';
import 'package:watch_it/watch_it.dart';

import '../setup/setup.dart';

(SharedPreferencesAsync, FakeSharedPreferencesAsync) getPreferences() {
  final store = FakeSharedPreferencesAsync();
  SharedPreferencesAsyncPlatform.instance = store;
  final preferences = SharedPreferencesAsync();
  return (preferences, store);
}

void main() {
  setUp(() async {
    startUpOnce();
    getPreferences();

    await di.reset();
    registerDependencies();
  });

  test('registerDependencies should register all dependencies', () async {
    // Act
    await di.allReady();

    // Assert
    expect(di.isRegistered<FoodSearchManager>(), true);
    // expect(
    //   // ignore: strict_raw_type
    //   di.isRegistered<PreferencesService>(
    //     instanceName: LocatorName.sharedPrefsService,
    //   ),
    //   true,
    // );
    expect(
      di.isRegistered<FoodsDB>(instanceName: LocatorName.foodsDBService),
      true,
    );
  });

  test('SharedPreferences should be initialized', () async {
    // Act
    // ignore: strict_raw_type
    final prefs = await di.getAsync<PreferencesService>(
      instanceName: LocatorName.sharedPrefsService,
    );

    // Assert
    expect(prefs, isNotNull);
  });

  test('UsdaDB should be initialized and data loaded', () async {
    // Act
    final db = await di.getAsync<FoodsDB>(
      instanceName: LocatorName.foodsDBService,
    );

    // Assert
    expect(db, isNotNull);
  });
}

base class FakeSharedPreferencesAsync extends SharedPreferencesAsyncPlatform {
  final InMemorySharedPreferencesAsync backend =
      InMemorySharedPreferencesAsync.empty();
  final List<MethodCall> log = <MethodCall>[];

  @override
  Future<bool> clear(
    ClearPreferencesParameters parameters,
    SharedPreferencesOptions options,
  ) {
    log.add(MethodCall('clear', <Object>[...?parameters.filter.allowList]));
    return backend.clear(parameters, options);
  }

  @override
  Future<bool?> getBool(String key, SharedPreferencesOptions options) {
    log.add(MethodCall('getBool', <String>[key]));
    return backend.getBool(key, options);
  }

  @override
  Future<double?> getDouble(String key, SharedPreferencesOptions options) {
    log.add(MethodCall('getDouble', <String>[key]));
    return backend.getDouble(key, options);
  }

  @override
  Future<int?> getInt(String key, SharedPreferencesOptions options) {
    log.add(MethodCall('getInt', <String>[key]));
    return backend.getInt(key, options);
  }

  @override
  Future<Set<String>> getKeys(
      GetPreferencesParameters parameters, SharedPreferencesOptions options) {
    log.add(MethodCall('getKeys', <String>[...?parameters.filter.allowList]));
    return backend.getKeys(parameters, options);
  }

  @override
  Future<Map<String, Object>> getPreferences(
      GetPreferencesParameters parameters, SharedPreferencesOptions options) {
    log.add(MethodCall(
        'getPreferences', <Object>[...?parameters.filter.allowList]));
    return backend.getPreferences(parameters, options);
  }

  @override
  Future<String?> getString(String key, SharedPreferencesOptions options) {
    log.add(MethodCall('getString', <String>[key]));
    return backend.getString(key, options);
  }

  @override
  Future<List<String>?> getStringList(
      String key, SharedPreferencesOptions options) {
    log.add(MethodCall('getStringList', <String>[key]));
    return backend.getStringList(key, options);
  }

  @override
  Future<bool> setBool(
      String key, bool value, SharedPreferencesOptions options) {
    log.add(MethodCall('setBool', <Object>[key, value]));
    return backend.setBool(key, value, options);
  }

  @override
  Future<bool> setDouble(
      String key, double value, SharedPreferencesOptions options) {
    log.add(MethodCall('setDouble', <Object>[key, value]));
    return backend.setDouble(key, value, options);
  }

  @override
  Future<bool> setInt(String key, int value, SharedPreferencesOptions options) {
    log.add(MethodCall('setInt', <Object>[key, value]));
    return backend.setInt(key, value, options);
  }

  @override
  Future<bool> setString(
      String key, String value, SharedPreferencesOptions options) {
    log.add(MethodCall('setString', <Object>[key, value]));
    return backend.setString(key, value, options);
  }

  @override
  Future<bool> setStringList(
      String key, List<String> value, SharedPreferencesOptions options) {
    log.add(MethodCall('setStringList', <Object>[key, value]));
    return backend.setStringList(key, value, options);
  }
}
