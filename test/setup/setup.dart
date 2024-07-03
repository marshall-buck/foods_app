// import 'package:foods_app/data/data.dart';

// import 'package:usda_db_package/usda_db_package.dart';
// import 'package:watch_it/watch_it.dart';

// Future<void> registerGetItTests() async {
//   await di.reset();
//   di.registerSingletonAsync<UsdaDB>(() async => await UsdaDB.init());
//   di.registerSingleton<FoodsDBInterface>(FoodsDBService());

//   print('from tests');
// }
import 'package:flutter_test/flutter_test.dart';

void startUpOnce() {
  TestWidgetsFlutterBinding.ensureInitialized();
}
