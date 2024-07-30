import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:foods_app/common/colors.dart';
import 'package:foods_app/common/constants.dart';

import 'package:foods_app/common/service_locator.dart';
import 'package:foods_app/common/theme.dart';
import 'package:foods_app/features/food_search/managers/search_delegate.dart';

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
      ),
      darkTheme: ThemeData.dark().copyWith(
        extensions: <ThemeExtension<dynamic>>[darkColors],
      ),
      themeMode: ThemeMode.light,
      home: const MyScaffold(),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    final searchBar = SearchBar(
      hintText: 'Search For Foods',
      backgroundColor: WidgetStateProperty.all(colors.surfaceContainer),
      onTap: () => showSearch(
        context: context,
        delegate: FoodSearchDelegate(),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: di.allReady(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // print('FutureBuilder');
            if (snapshot.hasData) {
              // print('returning HomePage');
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRect(
                          child: ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaX: 11.4, sigmaY: 11.4),
                            child: Image.asset(
                              orangesImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ClipRect(
                          child: Opacity(
                            opacity: 0.5,
                            child: ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 11.4, sigmaY: 11.4),
                              child: Image.asset(
                                appleImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Center(
                      child: searchBar,
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              print('Snapshot error from LoadingWidget : ${snapshot.error}');
              print(
                  'Snapshot stacktrace from LoadingWidget: ${snapshot.stackTrace}');
              return Column(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error from LoadingWidget: ${snapshot.error}'),
                  ),
                ],
              );
            } else {
              // print('returning CircularProgressIndicator:  ${snapshot}');
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Text('Awaiting result...')
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
