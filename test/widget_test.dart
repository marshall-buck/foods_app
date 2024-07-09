import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/home_page.dart';

import 'setup/setup.dart';

void main() {
  startUpOnce();

  group('description', () {
    testWidgets('LoadingWidget shows CircularProgressIndicator while waiting',
        (WidgetTester tester) async {
      final Future<String> _calculation = Future<String>.delayed(
        const Duration(seconds: 2),
        () => 'Data Loaded',
      );

      await tester.pumpWidget(
          MaterialApp(home: MockLoadingWidget(future: _calculation)));

      await tester.pump();

      // Verify CircularProgressIndicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Awaiting result...'), findsOneWidget);
      await tester.pumpAndSettle();
    });
    testWidgets('LoadingWidget shows HomePage when data is available',
        (WidgetTester tester) async {
      final Future<String> _calculation = Future<String>.delayed(
        const Duration(seconds: 2),
        () => 'Data Loaded',
      );
      // Simulate the Future being completed with data
      await tester.pumpWidget(
          MaterialApp(home: MockLoadingWidget(future: _calculation)));
      await tester.pumpAndSettle(); // Trigger a frame

      // Verify HomePage is shown
      expect(find.byType(HomePage), findsOneWidget);
      await tester.pumpAndSettle();
    });
    testWidgets('LoadingWidget shows error message when there is an error',
        (WidgetTester tester) async {
      final Future<String?> _calculation = Future<String>.delayed(
        const Duration(seconds: 2),
        () => throw Exception('An error occurred'),
      );
      // Simulate the Future completing with an error
      await tester.pumpWidget(
          MaterialApp(home: MockLoadingWidget(future: _calculation)));
      await tester.pump(); // Trigger a frame
      await tester.pumpAndSettle();
      // Verify error message is shown
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.textContaining('Error: Exception: An error occurred'),
          findsOneWidget);
    });
  });
}

class MockLoadingWidget extends StatelessWidget {
  MockLoadingWidget({super.key, required Future this.future});
  final Future future;

  @override
  Widget build(BuildContext context) {
    print('build widget');
    return FutureBuilder(
      // future: testingInstance.allReady(),
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print('FutureBuilder');
        if (snapshot.hasData) {
          print('returning HomePage:  ${snapshot.data}');
          return const HomePage();
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Column(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ],
          );
        } else {
          print('returning CircularProgressIndicator:  ${snapshot}');
          return const Column(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ],
          );
        }
      },
    );
  }
}
