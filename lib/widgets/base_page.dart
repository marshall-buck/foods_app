import 'package:flutter/material.dart';

import 'package:foods_app/widgets/widgets.dart';

class BasePage extends StatelessWidget {
  // Optional title for the app bar

  const BasePage({required this.slivers, super.key, this.title});
  final List<Widget> slivers;
  final String? title;

  @override
  Widget build(BuildContext context) {
    // final foodManager = di.get<FoodSearchManager>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            onClearSearch: () {},
            textFieldKey: GlobalKey<ReusableTextFieldState>(),
          ),
          ...slivers,
        ],
      ),
    );
  }
}
