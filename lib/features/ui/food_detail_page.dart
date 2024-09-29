import 'package:flutter/material.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';

import 'package:watch_it/watch_it.dart';

class FoodDetail extends WatchingStatefulWidget {
  const FoodDetail({super.key});

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  final _textFieldKey = GlobalKey<FoodsAppSearchBarState>();

  Future<void> _clearSearch() async {
    // await foodManager.clearSearch();
    _textFieldKey.currentState?.clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    final details = watchValue((FoodDetailManager m) => m.currentFood);
    return NotificationListener<FoodsAppSearchBarNotification>(
      onNotification: (notification) {
        return true;
      },
      child: BasePage(
        slivers: [SliverToBoxAdapter(child: Text(details!.description))],
        textFieldKey: _textFieldKey,
        onClearSearch: _clearSearch,
        showBadge: false,
      ),
    );
  }
}
