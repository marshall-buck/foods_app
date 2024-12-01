import 'package:flutter/material.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/ui/search_results_page.dart';

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
      debugShowCheckedModeBanner: false,

      // showSemanticsDebugger: true,
      theme: const AppTheme(appTextTheme).light(),

      darkTheme: const AppTheme(appTextTheme).dark(),

      home: FutureBuilder(
        future: di.allReady(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else {
            if (snapshot.error != null) {
              return ErrorScreen(snapshot: snapshot);
            } else {
              return const SearchResultsPage();
              // return const LoadingScreen();
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
