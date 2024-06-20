import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_app/common/colors.dart';
import 'package:foods_app/common/theme.dart';
import 'package:foods_app/data/data_source_providers/local_db.dart';

import 'package:usda_db_package/usda_db_package.dart';

void main() async {
  final db = await UsdaDB.init();
  runApp(ProviderScope(
    overrides: [usdaDBProvider.overrideWithValue(db)],
    child: const MainApp(),
  ));
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
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Center(
        child: Text(
          'Hello World!',
          style: TextStyle(color: colors.onSurface),
        ),
      ),
    );
  }
}
