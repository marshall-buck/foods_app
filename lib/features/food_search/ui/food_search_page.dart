import 'package:flutter/material.dart';

import 'package:foods_app/features/food_search/food_search.dart';
import 'package:watch_it/watch_it.dart';

class FoodSearchPage extends StatefulWidget {
  const FoodSearchPage({super.key, this.additionalSlivers});

  final List<Widget>? additionalSlivers;

  @override
  State<FoodSearchPage> createState() => _FoodSearchPageState();
}

//TODO: Figure out what happens on backspaces

class _FoodSearchPageState extends State<FoodSearchPage> {
  final foodManager = di.get<FoodSearchManager>();
  final TextEditingController _searchTermController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchTermController.addListener(_onSearchTermChanged);
  }

  @override
  void dispose() {
    _searchTermController.removeListener(_onSearchTermChanged);
    _searchTermController.dispose();
    super.dispose();
  }

  void _onSearchTermChanged() async {
    print('_onSearchTermChanged: ${_searchTermController.text}');

    await foodManager.queryFoods(searchTerm: _searchTermController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            // automaticallyImplyLeading: false,
            actions: const [FoodResultsCountBadge()],
            floating: true,
            title: TextField(
              controller: _searchTermController,
              decoration: const InputDecoration(
                hintText: 'Search for food...',
              ),
            ),
          ),
          ...?widget.additionalSlivers,
          FoodsList(),
        ],
      ),
    );
  }
}

class FoodResultsCountBadge extends WatchingWidget {
  const FoodResultsCountBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final count = watchValue((FoodSearchManager m) => m.currentResults);
    return Badge.count(count: count.length);
  }
}

class FoodsList extends StatelessWidget {
  FoodsList({super.key});

  final foodManager = di.get<FoodSearchManager>();

  @override
  Widget build(BuildContext context) {
    print('FoodsList: building');
    return ValueListenableBuilder<List<FoodListItemModel?>>(
      valueListenable: foodManager.currentResults,
      builder: (BuildContext context, value, Widget? child) {
        if (value.isEmpty) {
          return SliverToBoxAdapter(
            child: Text(
              'No results found.',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                print('SliverChildBuilderDelegate: building');
                final food = value[index];

                final id = food!.id;
                final key = ValueKey<int>(id);
                return FoodListItem(key: key, food: food);
              },
              childCount: value.length,
            ),
          );
        }
      },
    );
  }
}
