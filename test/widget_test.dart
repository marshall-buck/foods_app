// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:foods_app/main.dart';
// import 'package:usda_db_package/usda_db_package.dart';
// import 'package:watch_it/watch_it.dart';

// void main() {
//   setUp(() {
//     di.reset();
//   });

//   testWidgets('LoadingWidget shows CircularProgressIndicator while waiting',
//       (WidgetTester tester) async {
//     // Arrange
//     di.registerSingletonAsync<UsdaDB>(() async {
//       return await UsdaDB.init();
//     });

//     // Act
//     await tester.pumpWidget(const MaterialApp(home: LoadingWidget()));

//     // Assert
//     expect(find.byType(CircularProgressIndicator), findsOneWidget);

//     // Manually pump the widget tree and introduce delays
//     await tester.pump(const Duration(seconds: 1));
//     expect(find.byType(CircularProgressIndicator), findsOneWidget);

//     await tester.pump(const Duration(seconds: 1));
//     await tester.pump(); // Ensure all async operations are completed

//     // Assert
//     expect(find.byType(HomePage), findsOneWidget);
//   });

//   // testWidgets('LoadingWidget shows HomePage when ready',
//   //     (WidgetTester tester) async {
//   //   // Arrange
//   //   di.registerSingletonAsync<UsdaDB>(() async {
//   //     return await UsdaDB.init();
//   //   });

//   //   // Act
//   //   await tester.pumpWidget(const MaterialApp(home: LoadingWidget()));

//   //   // Manually pump the widget tree and introduce delays
//   //   await tester.pump(const Duration(seconds: 1));
//   //   await tester.pump(const Duration(seconds: 1));
//   //   await tester.pump(); // Ensure all async operations are completed

//   //   // Assert
//   //   expect(find.byType(HomePage), findsOneWidget);
//   // });

//   // testWidgets('HomePage displays correct content', (WidgetTester tester) async {
//   //   // Act
//   //   await tester.pumpWidget(const MaterialApp(home: HomePage()));

//   //   // Assert
//   //   expect(find.text('Hello World!'), findsOneWidget);
//   //   expect(find.byType(SearchBar), findsOneWidget);
//   // });
// }
