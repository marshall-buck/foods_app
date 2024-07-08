import 'package:foods_app/data/data_B.dart';
import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

import 'common/constants.dart';

registerDependencies() {
  di.registerSingletonAsync<UsdaDB>(() async {
    final db = UsdaDB();
    await db.init();
    return db;
  }, dispose: (x) async => await x.dispose());
  di.registerSingletonWithDependencies<FoodsDBInterface>(() => FoodsDB(),
      instanceName: LocatorName.foodsDBService.name, dependsOn: [UsdaDB]);
}
