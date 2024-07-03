import 'package:flutter/material.dart';

import 'package:foods_app/common/colors.dart';
import 'package:foods_app/common/theme.dart';
import 'package:foods_app/constants.dart';

import 'package:foods_app/data/interfaces/foods_db_interface.dart';
import 'package:foods_app/data/services/db_service.dart';

import 'package:usda_db_package/usda_db_package.dart';

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
        // brightness: Brightness.light,
        extensions: <ThemeExtension<dynamic>>[lightColors],
      ),
      darkTheme: ThemeData.dark().copyWith(
        // brightness: Brightness.dark,
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
    return FutureBuilder(
      future: di.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print('Original snapshot: $snapshot');
        if (snapshot.connectionState == ConnectionState.done) {
          print('ConnectionState.done snapshot: $snapshot');
          if (snapshot.hasError) {
            print('snapshot.hasError: ${snapshot.error}');
            return Text('error:  ${snapshot.error}');
          }
          print('Returning HomePage');
          return HomePage();
          // return const HomePage();
        } else {
          print('Returning CircularProgressIndicator');
          return CircularProgressIndicator.adaptive();
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
    // FoodsDBInterface db = di.get<FoodsDBInterface>(
    //     instanceName: ServiceInstance.foodsDBService.string);
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
              onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }
}

registerGetIt() {
  di.registerSingletonAsync<UsdaDB>(() async => await UsdaDB.init(),
      instanceName: ServiceInstance.usdaDBService.string);
  di.registerSingleton<FoodsDBInterface>(FoodsDBService(),
      instanceName: ServiceInstance.foodsDBService.string);
}
