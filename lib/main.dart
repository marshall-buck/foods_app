import 'package:flutter/material.dart';

import 'package:foods_app/common/colors.dart';
import 'package:foods_app/common/theme.dart';
import 'package:foods_app/constants.dart';
import 'package:foods_app/data/interfaces/foods_db_interface.dart';
import 'package:foods_app/registrations.dart';

import 'package:watch_it/watch_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerGetIt();
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

  @override
  Widget build(BuildContext context) {
    print('build widget');
    return FutureBuilder(
      future: di.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print('returning HomePage:  ${snapshot.data}');
          return const HomePage();
        } else {
          print('returning CircularProgressIndicator:  ${snapshot}');
          return CircularProgressIndicator();
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
    late final colors = Theme.of(context).extension<AppColorsExtension>();
    final db = di.get<FoodsDBInterface>(
        instanceName: ServiceInstance.foodsDBService.string);

    return Scaffold(
      backgroundColor: colors?.surface,
      body: Center(
        child: Column(
          children: [
            Text(
              'Hello World!',
              style: TextStyle(color: colors?.onSurface),
            ),
            SearchBar(
              onTap: () async => print(await db.queryFood(id: 167512)),
            ),
          ],
        ),
      ),
    );
  }
}
