import 'dart:developer';

import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foods_app/app_bloc_observer.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/data.dart';

import 'package:usda_db_package/usda_db_package.dart';

//

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };
  Bloc.observer = const AppBlocObserver();
  final localDatabase = UsdaDB();
  await localDatabase.init();

  // initializes auto_hyphenating_text package,
  await initHyphenation();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<void> init() async {
    Future.delayed(const Duration(seconds: 1), () {
      print('One second has passed.'); // Prints after 1 second.
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // showSemanticsDebugger: true,
      theme: const AppTheme(appTextTheme).light(),

      darkTheme: const AppTheme(appTextTheme).dark(),

      home: FutureBuilder(
        future: init(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else {
            if (snapshot.error != null) {
              return ErrorScreen(snapshot: snapshot);
            } else {
              return const Text('text');
              // return const SearchResultsPage();
            }
          }
        },
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({required this.snapshot, super.key});
  final AsyncSnapshot<void> snapshot;

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
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: SizedBox(
          width: 48,
          height: 48,
          child: Transform.scale(
            scale: 2,
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
