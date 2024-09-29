import 'package:flutter/material.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';

import 'package:watch_it/watch_it.dart';

class FoodSearchPage extends StatefulWidget {
  const FoodSearchPage({super.key});

  @override
  State<FoodSearchPage> createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends State<FoodSearchPage> {
  final foodManager = di.get<FoodSearchManager>();
  final _textFieldKey = GlobalKey<FoodsAppSearchBarState>();

  final ScrollController _controllerScroll = ScrollController();

  Future<void> _clearSearch() async {
    await foodManager.clearSearch();
    _textFieldKey.currentState?.clearSearch();
  }

  void _onTap() {}

  Future<void> _queryFoods(String searchTerm) async {
    await foodManager.queryFoods(searchTerm: searchTerm);
  }

  @override
  void initState() {
    _controllerScroll.addListener(_onTap);
    super.initState();
  }

  @override
  void dispose() {
    _textFieldKey.currentState?.dispose();
    super.dispose();
  }

  late final Widget appBar = SliverPadding(
    padding: const EdgeInsets.only(bottom: 4),
    sliver: CustomSliverAppBar(
      textFieldKey: _textFieldKey,
      onClearSearch: _clearSearch,
    ),
  );

  @override
  Widget build(BuildContext context) {
    // print('_FoodSearchPageState build');
    return NotificationListener<FoodsAppSearchBarNotification>(
      onNotification: (notification) {
        _queryFoods(notification.text);
        return true;
      },
      child: BasePage(
        scrollController: _controllerScroll,
        slivers: [appBar, const FoodsList()],
      ),
    );
  }
}
