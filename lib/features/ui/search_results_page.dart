import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:watch_it/watch_it.dart';

class SearchResultsPage extends WatchingStatefulWidget {
  const SearchResultsPage({super.key, this.termFromHome});
  final String? termFromHome;

  @override
  State<SearchResultsPage> createState() => _FoodsListState();
}

class _FoodsListState extends State<SearchResultsPage> {
  final _searchBarController = TextEditingController();
  Future<void> _onTap(BuildContext context, ValueKey<int> id) async {
    await di.get<FoodDetailManager>().queryFood(id.value);
    if (context.mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute<FoodDetail>(builder: (context) => const FoodDetail()),
      );
    }
  }

  Future<void> _onChanged() async {
    await di.get<FoodSearchManager>().queryFoods(_searchBarController.text);
  }

  void _onClearSearch() {
    _searchBarController.clear();
    di.get<FoodSearchManager>().clearSearch();
  }

  @override
  void initState() {
    if (widget.termFromHome != null) {
      _searchBarController.text = widget.termFromHome!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodResults = watchValue((FoodSearchManager x) => x.currentResults);

    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: MagicStrings.searchBarHeroTag,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: MagicNumbers.maxSearchBarWidth,
                    minWidth: MagicNumbers.minSearchBarWidth,
                    maxHeight: MagicNumbers.searchBarHeight,
                    minHeight: MagicNumbers.searchBarHeight,
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
                    onChanged: (string) => _onChanged(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final food = foodResults[index];

                  final id = ValueKey<int>(food!.id);
                  return GestureDetector(
                    onTap: () => _onTap(context, id),
                    child: FoodListItem(
                      key: id,
                      food: food,
                    ),
                  );
                },
                itemCount: foodResults.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
