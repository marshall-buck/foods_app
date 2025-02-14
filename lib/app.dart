import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';

import 'package:foods_app/food_search/food_search.dart';
import 'package:foods_app/user_preferences/user_preferences.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPreferencesBloc, UserPreferencesState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: const AppTheme(appTextTheme).light(),
          darkTheme: const AppTheme(appTextTheme).dark(),
          home: const SearchResultsPage(),
        );
      },
    );
  }
}
