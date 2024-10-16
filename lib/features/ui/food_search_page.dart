import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';

import 'package:watch_it/watch_it.dart';

class FoodSearchPage extends StatefulWidget {
  const FoodSearchPage({super.key});

  @override
  State<FoodSearchPage> createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends State<FoodSearchPage> {
  final _textFieldKey = GlobalKey<FoodsAppSearchBarState>();

  final ScrollController _scrollController = ScrollController();

  Future<void> _clearSearch() async {
    final foodManager = di.get<FoodSearchManager>();
    await foodManager.clearSearch();
    _textFieldKey.currentState?.clearSearch();
  }

  Future<void> _queryFoods(String searchTerm) async {
    final foodManager = di.get<FoodSearchManager>();
    await foodManager.queryFoods(searchTerm: searchTerm);
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
    _scrollController
      ..removeListener(_onScrollListener)
      ..dispose();
    _textFieldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: NotificationListener<FoodsAppSearchBarNotification>(
        onNotification: (notification) {
          _queryFoods(notification.text);
          return true;
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 4),
              sliver: CustomSliverAppBar(
                // scrollController: _scrollController,
                textFieldKey: _textFieldKey,
                onClearSearch: _clearSearch,
              ),
            ),
            const FoodsList(),
          ],
        ),
      ),
    );
  }
}
