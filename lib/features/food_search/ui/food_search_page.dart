import 'package:flutter/material.dart';

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
    print(_searchTermController.text);
    if (_searchTermController.text.length >= 2) {
      await foodManager.queryFoods(searchTerm: _searchTermController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Material(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              // pinned: true,
              floating: true,
              title: TextField(
                controller: _searchTermController,
                decoration: const InputDecoration(
                  hintText: 'Search for food...',
                ),
              ),
            ),
            ...?widget.additionalSlivers,
            FoodsList(
              foodManager: foodManager,
            ),
          ],
        ),
      ),
    );
  }
}

class FoodsList extends StatelessWidget {
  const FoodsList({super.key, required this.foodManager});

  final FoodSearchManager foodManager;

  @override
  Widget build(BuildContext context) {
    if (foodManager.currentResults.value == null) {
      return const SliverToBoxAdapter(
        child: Text('stuff'),
      );
    } else {
      return ValueListenableBuilder(
        valueListenable: foodManager.currentResults,
        builder: (BuildContext context, value, Widget? child) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final foods = value;

                final id = foods![index].id;
                final key = ValueKey<int>(id);
                return FoodListItem(key: key, food: foods[index]);
              },
              // childCount: foods.length,
            ),
          );
        },
      );
    }
  }
}


// FutureBuilder<List<FoodListItemModel?>>(
//               future: foodManager.getMockData(),
//               builder: (BuildContext context, AsyncSnapshot snapshot) {
//                 if (snapshot.hasData) {
//                   final List<FoodListItemModel> foods = snapshot.data;
//                   return SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                       (BuildContext context, int index) {
//                         return FoodListItem(foods: foods, index: index);
//                         // return Column(
//                       },
//                       childCount: foods.length,
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   print('Snapshot error: ${snapshot.error}');
//                   print('Snapshot stacktrace: ${snapshot.stackTrace}');
//                   return SliverToBoxAdapter(
//                     child: Column(
//                       children: [
//                         const Icon(
//                           Icons.error_outline,
//                           size: 24,
//                           color: Colors.blueAccent,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 16),
//                           child: Text('Error: ${snapshot.error}'),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else {
//                   return const SliverToBoxAdapter(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           width: 60,
//                           height: 60,
//                           child: CircularProgressIndicator.adaptive(),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: 16),
//                           child: Text('Awaiting result...'),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               },
//             ),