import 'package:flutter/material.dart';
import 'package:foods_app/features/food_search/managers/food_search_manager.dart';
import 'package:foods_app/features/food_search/ui/foods_list.dart';

import '../../../common/theme.dart';

class FoodSearchResultsList extends StatelessWidget {
  const FoodSearchResultsList({
    super.key,
    required this.foodManager,
    required this.colors,
  });

  final FoodSearchManager foodManager;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: foodManager.getMockData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            color: colors.surface,
            child: FoodsList(foods: snapshot.data),
          );
        } else if (snapshot.hasError) {
          print('Snapshot error: ${snapshot.error}');
          print('Snapshot stacktrace: ${snapshot.stackTrace}');
          return Column(
            children: [
              const Icon(
                Icons.error_outline,
                size: 24,
                color: Colors.blueAccent,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ],
          );
        } else {
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
        }
      },
    );
  }
}
