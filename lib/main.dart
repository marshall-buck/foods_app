import 'package:flutter/material.dart';

import 'package:foods_app/common/colors.dart';
import 'package:foods_app/common/theme.dart';
import 'package:foods_app/constants.dart';
import 'package:foods_app/data/interfaces/foods_db_interface.dart';
import 'package:foods_app/registrations.dart';

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
      home: const LoadingWidget(),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  // final Future<String> _calculation = Future<String>.delayed(
  //   const Duration(seconds: 2),
  //   () => 'Data Loaded',
  //);
  @override
  Widget build(BuildContext context) {
    print('build widget');
    return FutureBuilder(
      future: di.allReady(),
      // future: _calculation,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print('FutureBuilder');
        if (snapshot.hasData) {
          print('returning HomePage:  ${snapshot.data}');
          return const HomePage();
        } else if (snapshot.hasError) {
          print('Snapshot error: ${snapshot.error}');
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
          ;
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('building HomePage');
    // late final colors = Theme.of(context).extension<AppColorsExtension>();
    late final FoodsDBInterface db = di.get<FoodsDBInterface>(
        instanceName: ServiceInstance.foodsDBService.string);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello World!',
            ),
            Text('${di.isReady(instance: db)}'),
            SearchBar(
              onTap: () async => print(await db.queryFood(id: 167512)),
            ),
          ],
        ),
      ),
    );
  }
}
