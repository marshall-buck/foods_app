import 'package:flutter/material.dart';
import 'package:foods_app/features/food_search/managers/food_search_manager.dart';
import 'package:foods_app/features/food_search/managers/food_search_results_list.dart';
import 'package:watch_it/watch_it.dart';

import '../../../common/theme.dart';

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
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    if (query.length >= 2) {
      return FoodSearchResultsList(foodManager: foodManager, colors: colors);
    } else {
      // TODO: Change to something else
      return const Text('No Result Found');
    }
  }
}
