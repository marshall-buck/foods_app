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
    return MaterialApp(
        theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[lightColors],
            textTheme: appTextTheme),
        darkTheme: ThemeData.dark().copyWith(
            extensions: <ThemeExtension<dynamic>>[darkColors],
            textTheme: appTextTheme),
        themeMode: ThemeMode.system,
        home: FutureBuilder(
            future: di.allReady(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              } else {
                if (snapshot.error != null) {
                  return ErrorScreen(snapshot: snapshot);
                } else {
                  return const HomePage();
                  // return const LoadingScreen();
                }
              }
            }));
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.error_outline,
          // color: Colors.red,
          size: 48,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('Error from LoadingWidget: ${snapshot.error}'),
        ),
      ],
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorsExtension.of(context).background,
      child: Center(
        child: SizedBox(
          width: 48,
          height: 48,
          child: Transform.scale(
            scale: 2.0,
            child: CircularProgressIndicator.adaptive(
              backgroundColor: AppColorsExtension.of(context).onBackground,
            ),
          ),
        ),
      ),
    );
  }
}
