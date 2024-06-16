import 'package:flutter/material.dart';
import 'package:foods_app/common/colors.dart';
import 'package:foods_app/common/theme.dart';

void main() {
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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
