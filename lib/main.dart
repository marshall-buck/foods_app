import 'package:flutter/material.dart';
import 'package:foods_app/app_loader.dart';
import 'package:foods_app/common/zcommon.dart';

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
      home: const Scaffold(
        body: SafeArea(
          child: AppLoader(),
        ),
      ),
    );
  }
}
