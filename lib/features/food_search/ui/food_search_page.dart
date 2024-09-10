import 'package:flutter/material.dart';
import 'package:foods_app/common/reusable_text.dart';
import 'package:foods_app/common/theme.dart';

import 'package:foods_app/features/food_search/food_search.dart';

import 'package:watch_it/watch_it.dart';

class FoodSearchPage extends StatefulWidget {
  const FoodSearchPage({super.key, this.additionalSlivers});

  final List<Widget>? additionalSlivers;

  @override
  State<FoodSearchPage> createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends State<FoodSearchPage> {
  final foodManager = di.get<FoodSearchManager>();
  final _childKey = GlobalKey<ReusableTextFieldState>();

  final ScrollController _controllerScroll = ScrollController();

  void _onSearchTermChanged(TextChangeNotification notification) async {
    final text = notification.text;
    print('_onSearchTermChanged: $text');

    await foodManager.queryFoods(searchTerm: text);
  }

  void _clearSearch() async {
    await foodManager.clearSearch();
    _childKey.currentState?.clearSearch();
  }

  void _onTap() {
    print(_controllerScroll.initialScrollOffset);
  }

  @override
  void initState() {
    _controllerScroll.addListener(_onTap);
    super.initState();
  }

  @override
  void dispose() {
    _childKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_FoodSearchPageState build');
    return Scaffold(
      body: CustomScrollView(
        controller: _controllerScroll,
        slivers: [
          SliverAppBar(
            surfaceTintColor: AppColorsExtension.of(context).surfaceTint,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                    onPressed: _clearSearch,
                    icon: const Icon(Icons.clear_outlined)),
              ),
              const _FoodResultsCountBadge(),
            ],
            floating: true,
            title: NotificationListener<TextChangeNotification>(
              child: ReusableTextField(
                key: _childKey,
              ),
              onNotification: (notification) {
                _onSearchTermChanged(notification);
                return true;
              },
            ),
            pinned: true,
          ),
          ...?widget.additionalSlivers,
          const FoodsList(),
        ],
      ),
    );
  }
}

class _FoodResultsCountBadge extends WatchingWidget {
  const _FoodResultsCountBadge();

  @override
  Widget build(BuildContext context) {
    final count = watchValue((FoodSearchManager m) => m.currentResults);
    return Badge.count(count: count.length);
  }
}
