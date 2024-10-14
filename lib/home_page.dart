import 'package:flutter/material.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  void _navigateAway(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<FoodDetail>(
        builder: (context) => const FoodSearchPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
          child: SizedBox(
            width: MagicNumbers.maxSearchBarWidth,
            child: Hero(
              tag: MagicStrings.searchBarHeroTag,
              child: FoodsAppSearchBar(
                hintText: MagicStrings.searchPageHintText,
                onTap: () => _navigateAway(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeSearch extends StatelessWidget {
  const HomeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: FoodsAppSearchBar(hintText: MagicStrings.searchPageHintText),
    );
  }
}
