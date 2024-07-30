import 'package:flutter/material.dart';
import 'package:foods_app/features/food_search/managers/food_search_manager.dart';

import 'package:foods_app/features/food_search/ui/foods_list.dart';

import 'package:watch_it/watch_it.dart';

class FoodSearchDelegate extends SearchDelegate {
  final foodManager = di.get<FoodSearchManager>();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query.isEmpty ? close(context, null) : query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults Called');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length >= 2) {
      return FutureBuilder(
        future: foodManager.getMockData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return FoodsList(foods: snapshot.data);
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
    } else {
      return const Text('No Result Found');
    }
  }
}
