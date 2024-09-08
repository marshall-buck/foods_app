import 'package:flutter/material.dart';
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
  final TextEditingController _controller = TextEditingController();

  void _onSearchTermChanged() async {
    final text = _controller.text;
    print('_onSearchTermChanged: $text');

    await foodManager.queryFoods(searchTerm: text);
  }

  void _clearSearch() async {
    await foodManager.clearSearch();
    _controller.clear();
  }

  @override
  void initState() {
    _controller.addListener(_onSearchTermChanged);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_clearSearch);
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_FoodSearchPageState build');
    return Scaffold(
      body: CustomScrollView(
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
            title: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                hintText: 'Search for food...',
              ),
            ),
            pinned: true,
          ),
          ...?widget.additionalSlivers,
          FoodsList(),
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
