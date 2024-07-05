import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/constants.dart';
import 'package:foods_app/data/interfaces/foods_db_interface.dart';
import 'package:foods_app/data/services/db_service.dart';
import 'package:foods_app/main.dart';

import 'package:usda_db_package/usda_db_package.dart';
import 'package:watch_it/watch_it.dart';

void main() {
  // setUp(() async {
  //   await di.reset();
  //   di.registerSingletonAsync<UsdaDB>(() async => UsdaDB.init(),
  //       dispose: (x) async => await x.dispose());
  //   di.registerSingletonWithDependencies<FoodsDBInterface>(
  //       () => FoodsDBService(),
  //       instanceName: ServiceInstance.foodsDBService.string,
  //       dependsOn: [UsdaDB]);
  // });

  testWidgets(
      'LoadingWidget displays CircularProgressIndicator and then HomePage',
      (WidgetTester tester) async {
    await di.reset();
    di.registerSingletonAsync<UsdaDB>(() async => UsdaDB.init(),
        dispose: (x) async => await x.dispose());
    di.registerSingletonWithDependencies<FoodsDBInterface>(
        () => FoodsDBService(),
        instanceName: ServiceInstance.foodsDBService.string,
        dependsOn: [UsdaDB]);
    await tester.pumpWidget(const MainApp());
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });
}
//  await tester.pumpWidget(const TestWrapper(child: AddTodoSheet()));