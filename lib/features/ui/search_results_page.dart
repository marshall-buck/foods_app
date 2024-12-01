import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:watch_it/watch_it.dart';

// TODO: Put in quicksearchresults
class SearchResultsPage extends WatchingStatefulWidget {
  const SearchResultsPage({super.key});

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
        MaterialPageRoute<FoodDetailPage>(
          builder: (context) => const FoodDetailPage(),
        ),
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
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foodResults = watchValue((FoodSearchManager x) => x.currentResults);
    final height = MediaQuery.sizeOf(context).height;
    final padding = MediaQuery.paddingOf(context);
    final centeredSearchBarTop =
        (height / 2) - (MagicDimensions.searchBarHeight / 2) - (padding.top);

    return Material(
      child: SafeArea(
        child: Column(
          children: [
            AnimatedPadding(
              duration: MagicDurations.base2,
              padding: foodResults.isEmpty
                  ? EdgeInsets.only(
                      top: centeredSearchBarTop,
                      right: MagicSpacing.sp_3,
                      left: MagicSpacing.sp_3,
                    )
                  : const EdgeInsets.symmetric(horizontal: MagicSpacing.sp_3),
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
                  onChanged: (string) => _onChanged(),
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
            ),
          ],
        ),
      ),
    );
  }
}
