import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:foods_app/common/common.dart';

import 'package:foods_app/ui/ui.dart';

import 'package:watch_it/watch_it.dart';

class FoodComparisonPage extends WatchingStatefulWidget {
  const FoodComparisonPage({super.key});

  @override
  State<FoodComparisonPage> createState() => _FoodComparisonPageState();
}

class _FoodComparisonPageState extends State<FoodComparisonPage> {
  final _searchBarController = TextEditingController();
  final _scrollController = ScrollController();

  bool _showQuickResults = false;
  bool _isSearching = true;

  Future<void> _onTapFoodListItem(
    ValueKey<int> id,
  ) async {
    // di.get<AppHistoryState>().addTermToHistory(_searchBarController.text);
    await di.get<FoodSearchManager>().queryFood(id.value);
    dev.log(
      '${di.get<FoodSearchManager>().currentResults}',
      name: 'FoodComparisonPage:_onTapFoodListItem',
    );
    dev.log(
      '${di.get<FoodAmountManager>().amountStrings}',
      name: 'FoodComparisonPage:_onTapFoodListItem',
    );

    setState(() {
      _isSearching = false;
    });
  }

  Future<void> _onChanged() async {
    await di.get<FoodSearchManager>().queryFoods(_searchBarController.text);
    setState(() {});
  }

  void _onClearSearch() {
    _searchBarController.clear();

    di.get<FoodSearchManager>().clearSearch();
    _showQuickResults = false;
  }

  void _onScroll() {
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
    // watchIt<FoodSearchVM>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final foodSearchManager = di.get<FoodSearchManager>();
    final foodCompareManager = di.get<FoodCompareManager>();
    final width = MediaQuery.sizeOf(context).width;

    ///(dimension of a side, spacing)
    final tileSize = MagicTileDimension.tileSize(windowSize: width);
    return Material(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(MagicSpacing.sp_8),
          ),
          child: Column(
            spacing: MagicSpacing.sp_2,
            children: [
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: foodCompareManager.compareList.map((food) {
                  return FoodDescriptionCard(tileSize: tileSize, food: food!);
                }).toList(),
              ),
              // if (_isSearching == true)
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: MagicNumbers.maxSearchBarWidth,
                  minWidth: MagicNumbers.minSearchBarWidth,
                  maxHeight: MagicNumbers.searchBarHeight,
                  minHeight: MagicNumbers.searchBarHeight,
                ),
                child: SearchBar(
                  controller: _searchBarController,
                  constraints: Theme.of(context).searchBarTheme.constraints,
                  hintText: MagicStrings.compareSearchBarText,
                  trailing: [
                    if (foodSearchManager.hasResults)
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
              AnimatedContainer(
                // color: Colors.amber,
                duration: MagicDurations.base1,
                height: _showQuickResults ? 32 : 0,
                child: const QuickResultsContainer(),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    final food = foodSearchManager.currentResults[index];

                    final id = ValueKey<int>(food!.id);
                    return GestureDetector(
                      onTap: () => _onTapFoodListItem(id),
                      child: FoodListItem(
                        key: id,
                        food: food,
                      ),
                    );
                  },
                  itemCount: foodSearchManager.resultsCount,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
