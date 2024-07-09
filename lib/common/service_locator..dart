import 'package:foods_app/services/services_B.dart';

import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

enum LocatorName {
  usdaDBService('usdaDBService'),
  foodsDBService('foodsDBService'),
  externalDBService('externalDBService');

  final String _name;

  const LocatorName(this._name);

  String get name => _name;
}

registerDependencies() {
  di.registerSingletonAsync<UserPreferencesService>(() async {
    final settings = UserPreferencesService();
    await settings.init();
    return settings;
  });
  di.registerSingletonAsync<UsdaDB>(() async {
    final db = UsdaDB();
    await db.init();
    return db;
  }, dispose: (x) async => await x.dispose());
  di.registerSingletonWithDependencies<FoodsDBInterface>(() => FoodsDB(),
      instanceName: LocatorName.foodsDBService.name, dependsOn: [UsdaDB]);
}
