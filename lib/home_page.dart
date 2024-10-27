import 'package:flutter/material.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:watch_it/watch_it.dart';

class HomePage extends WatchingStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  final _searchBarController = TextEditingController();
  //

  Future<void> _onChanged(
    BuildContext context,
    String string,
  ) async {
    await di.get<FoodSearchManager>().queryFoods(_searchBarController.text);
    final isEmpty = di.get<FoodSearchManager>().currentResults.value.isEmpty;
    if (isEmpty) return;
    if (context.mounted) {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute<SearchResultsPage>(
          builder: (context) =>
              SearchResultsPage(termFromHome: _searchBarController.text),
        ),
      );
    }
  }

  void _onClearSearch() {
    _searchBarController.clear();
    di.get<FoodSearchManager>().clearSearch();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Hero(
          tag: MagicStrings.searchBarHeroTag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: MagicSpacing.sp_3),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: MagicDimensions.maxSearchBarWidth,
                minWidth: MagicDimensions.minSearchBarWidth,
                maxHeight: MagicDimensions.searchBarHeight,
                minHeight: MagicDimensions.searchBarHeight,
              ),
              child: SearchBar(
                controller: _searchBarController,
                constraints: Theme.of(context).searchBarTheme.constraints,
                hintText: MagicStrings.searchPageHintText,
                trailing: [
                  IconButton(
                    onPressed: _onClearSearch,
                    icon: const Icon(Icons.clear_outlined),
                  ),
                ],
                onChanged: (string) => _onChanged(context, string),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
