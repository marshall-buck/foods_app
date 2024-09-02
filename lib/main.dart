import 'package:flutter/material.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/home_page.dart';
import 'package:watch_it/watch_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: di.allReady(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else {
            if (snapshot.error != null) {
              return ErrorScreen(snapshot: snapshot);
            } else {
              return const SuccessfulLoad();
            }
          }
        });
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(
        children: [
          const Icon(
            Icons.error_outline,
            // color: Colors.red,
            size: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('Error from LoadingWidget: ${snapshot.error}'),
          ),
        ],
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator.adaptive(),
            ),
            Text('Awaiting result...')
          ],
        ),
      ),
    );
  }
}

class SuccessfulLoad extends StatelessWidget {
  const SuccessfulLoad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[lightColors],
      ),
      darkTheme: ThemeData.dark().copyWith(
        extensions: <ThemeExtension<dynamic>>[darkColors],
      ),
      themeMode: ThemeMode.system,
      home: const Scaffold(
        body: SafeArea(
          child: HomePage(),
        ),
      ),
    );
  }
}
