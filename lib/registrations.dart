import 'package:foods_app/constants.dart';
import 'package:foods_app/data/interfaces/foods_db_interface.dart';
import 'package:foods_app/data/services/db_service.dart';
import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

registerGetIt() {
  di.registerSingletonAsync<UsdaDB>(() async => UsdaDB.init(),
      dispose: (x) async => await x.dispose());
  di.registerSingletonWithDependencies<FoodsDBInterface>(() => FoodsDBService(),
      instanceName: ServiceInstance.foodsDBService.string, dependsOn: [UsdaDB]);
}
