// ignore: unused_import
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:watch_it/watch_it.dart';

class SearchResultsPage extends WatchingStatefulWidget {
  const SearchResultsPage({super.key});

  @override
  State<SearchResultsPage> createState() => _FoodsListState();
}

class _FoodsListState extends State<SearchResultsPage> {
  final _searchBarController = TextEditingController();
  final _scrollController = ScrollController();

  bool _showQuickResults = false;

  Future<void> _onTapFoodListItem(
    BuildContext context,
    ValueKey<int> id,
  ) async {
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
    setState(() {});
  }

  void _onClearSearch() {
    _searchBarController.clear();

    di.get<FoodSearchManager>().clearSearch();
  }

  void _onScroll() {
    // dev.log('_showQuickResults : $_showQuickResults',
    //     name: '_onScrollCalled top');
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _showQuickResults = true;
      });

      return;
    }
    setState(() {
      _showQuickResults = false;
    });
    // dev.log('_showQuickResults : $_showQuickResults',
    //     name: '_onScrollCalled bottom');
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    // watchIt<FoodSearchManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final foodResults =
    //     watchPropertyValue((FoodSearchManager x) => x.currentResults);
    final foodManager = watchIt<FoodSearchManager>();
    final height = MediaQuery.sizeOf(context).height;
    final padding = MediaQuery.paddingOf(context);
    final centeredSearchBarTop =
        (height / 2) - (MagicDimensions.searchBarHeight / 2) - (padding.top);
    final quickResultsList = di.get<QuickSearchManager>().quickSearchNames;

    return Material(
      child: SafeArea(
        child: Column(
          children: [
            AnimatedPadding(
              duration: MagicDurations.base2,
              padding: !foodManager.hasResults
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
                    if (foodManager.hasResults)
                      const FoodResultsCountBadge()
                    else
                      const Spacer(),
                    IconButton(
                      onPressed: _onClearSearch,
                      icon: const Icon(Icons.clear_outlined),
                    ),
                  ],
                  onChanged: (string) => _onChanged(),
                ),
              ),
            ),
            AnimatedContainer(
              // color: Colors.amber,
              duration: MagicDurations.base1,
              height: _showQuickResults ? 32 : 0,
              child: Row(
                children: quickResultsList.value.map((quickResult) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      quickResult,
                      style: AppTextStyle.m3LabelSmall.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  final food = foodManager.currentResults[index];

                  final id = ValueKey<int>(food!.id);
                  return GestureDetector(
                    onTap: () => _onTapFoodListItem(context, id),
                    child: FoodListItem(
                      key: id,
                      food: food,
                    ),
                  );
                },
                itemCount: foodManager.resultsCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
