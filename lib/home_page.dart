import 'package:flutter/material.dart';

import 'package:foods_app/features/food_search/managers/search_delegate.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('building HomePage');

    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          onTap: () => showSearch(
            context: context,
            delegate: FoodSearchDelegate(),
          ),
        ),
      ),
      // body: Center(
      //   child: Column(
      //     children: [
      //       Text(
      //         'Hello World!',
      //       ),
      //       SearchPage(),
      //     ],
      //   ),
      // ),
    );
  }
}
