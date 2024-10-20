import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';

import 'package:watch_it/watch_it.dart';

class FoodSearchPage extends StatefulWidget {
  const FoodSearchPage({super.key, this.searchBarInitialValue});
  final String? searchBarInitialValue;

  @override
  State<FoodSearchPage> createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends State<FoodSearchPage> {
  final ScrollController _scrollController = ScrollController();

  void _onClearSearch() {
    di.get<FoodSearchManager>().clearSearch();
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

  @override
  void initState() {
    _scrollController.addListener(_onScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    di.get<FoodSearchManager>().clearSearch();
    _scrollController
      ..removeListener(_onScrollListener)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop == true) {
          di.get<FoodSearchManager>().clearSearch();
        }
      },
      child: BasePage(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 4),
              sliver: CustomSliverAppBar(
                // onChanged: (_) {},
                showBadge: true,
                onClearSearch: _onClearSearch,
              ),
            ),
            const FoodsList(),
          ],
        ),
      ),
    );
  }
}
