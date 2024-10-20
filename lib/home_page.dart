import 'package:flutter/material.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';
import 'package:watch_it/watch_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _onChanged(BuildContext context, String string) async {
    di.get<FoodSearchManager>().updateSearch(string);
    final searchTerm = di.get<FoodSearchManager>().searchQueryString.value;

    if (searchTerm.length > 1) {
      await di.get<FoodSearchManager>().queryFoods();
      if (context.mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute<FoodDetail>(
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
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
    );
  }
}

// class HomeSearch extends StatelessWidget {
//   const HomeSearch({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: FoodsAppSearchBar(hintText: MagicStrings.searchPageHintText),
//     );
//   }
// }
