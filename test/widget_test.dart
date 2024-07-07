import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/constants.dart';
import 'package:foods_app/data/interfaces/foods_db_interface.dart';
import 'package:foods_app/data/services/db_service.dart';
import 'package:foods_app/main.dart';

import 'package:mocktail/mocktail.dart';

import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

import 'setup/setup.dart';

class MockUsdaDB extends Mock implements UsdaDB {}

class MockFoodsDBService extends Mock implements FoodsDBService {}

void main() {
  startUpOnce();
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    // await di.reset();
    di.registerSingletonAsync<MockUsdaDB>(() async {
      final db = MockUsdaDB();
      await db.init();
      return db;
    }, dispose: (x) async => await x.dispose());
    di.registerSingletonWithDependencies<FoodsDBInterface>(
        () => MockFoodsDBService(),
        instanceName: ServiceInstance.foodsDBService.string,
        dependsOn: [MockUsdaDB]);
  });
  tearDown(() async {
    await di.reset();
  });

  testWidgets(
      'LoadingWidget displays CircularProgressIndicator and then HomePage',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    // Wait for the FutureBuilder to complete

    // Verify that HomePage is displayed
    expect(find.byType(HomePage), findsOneWidget);
  });
}
