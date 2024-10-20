import 'package:flutter/material.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';
import 'package:watch_it/watch_it.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  Future<void> _onChanged(BuildContext context, String string) async {
    di.get<FoodSearchManager>().updateSearch(string);
    // final searchTerm = di.get<FoodSearchManager>().searchQueryString.value;

    await di.get<FoodSearchManager>().queryFoods();
    // print(di.get<FoodSearchManager>().searchQueryString.value);
    final lengthOfResults =
        di.get<FoodSearchManager>().currentResults.value.length;
    if (lengthOfResults > 0) {
      if (context.mounted) {
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute<FoodSearchPage>(
            builder: (context) => const FoodSearchPage(),
          ),
        );
      }
    }
  }

  void _onClearSearch() {
    di.get<FoodSearchManager>().clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
          child: SizedBox(
            width: MagicNumbers.maxSearchBarWidth,
            child: Hero(
              tag: MagicStrings.searchBarHeroTag,
              child: FoodsAppSearchBar(
                hintText: MagicStrings.searchPageHintText,
                showBadge: false,
                onClearSearch: _onClearSearch,
                onChanged: (String string) {
                  _onChanged(context, string);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
