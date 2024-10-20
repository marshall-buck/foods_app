import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foods_app/common/common.dart';

import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';

import 'package:watch_it/watch_it.dart';

class FoodSearchPage extends StatefulWidget {
  const FoodSearchPage({super.key});

  @override
  State<FoodSearchPage> createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends State<FoodSearchPage> {
  final ScrollController _scrollController = ScrollController();
  late final TextEditingController _searchController;

  void _onClearSearch() {
    di.get<FoodSearchManager>().clearSearch();
    _searchController.text =
        di.get<FoodSearchManager>().searchQueryString.value;
  }

  void _onScrollListener() {
    final quickSearchManager = di.get<QuickSearchManager>();
    if (ScrollDirection.forward ==
        _scrollController.position.userScrollDirection) {
      quickSearchManager.setOpacity(1);
    } else {
      quickSearchManager.setOpacity(0);
    }
  }

  Future<void> _onChanged(String string) async {
    di.get<FoodSearchManager>().updateSearch(string);

    await di.get<FoodSearchManager>().queryFoods();
  }

  @override
  void initState() {
    final searchString = di.get<FoodSearchManager>().searchQueryString.value;

    _scrollController.addListener(_onScrollListener);
    _searchController = TextEditingController(text: searchString);
    // _searchController.addListener(_onClearSearch);
    super.initState();
  }

  @override
  void dispose() {
    di.get<FoodSearchManager>().clearSearch();
    _scrollController
      ..removeListener(_onScrollListener)
      ..dispose();

    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 4),
            sliver: CustomSliverAppBar(
              titleWidget: Hero(
                tag: MagicStrings.searchBarHeroTag,
                child: FoodsAppSearchBar(
                  showBadge: true,
                  hintText: MagicStrings.searchPageHintText,
                  onChanged: _onChanged,
                  onClearSearch: _onClearSearch,
                ),
              ),
              flexSpaceWidget: const _QuickSearchHeader(),
            ),
          ),
          const FoodsList(),
        ],
      ),
    );
  }
}

class _QuickSearchHeader extends WatchingWidget {
  const _QuickSearchHeader();

  @override
  Widget build(BuildContext context) {
    final namesList = watchValue((QuickSearchManager m) => m.quickSearchNames);
    final opacity = watchValue((QuickSearchManager m) => m.opacity);
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: opacity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: namesList
                  .map(
                    (name) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        name,
                        style: AppTextStyle.m3BodySmall.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
