import 'package:flutter/material.dart';
import 'package:foods_app/features/food_search/food_search.dart';
import 'package:watch_it/watch_it.dart';

class FoodSearchPage extends StatefulWidget {
  const FoodSearchPage({
    super.key,
     this.additionalSlivers,
  });

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

  void _onSearchTermChanged() {
    foodManager.searchTerm.value = _searchTermController.text;
    // foodManager.queryFoods(searchTerm: _searchTermController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              title: TextField(
                controller: _searchTermController,
                decoration: const InputDecoration(
                  hintText: 'Search for food...',
                ),
              ),
            ),
            ...?widget.additionalSlivers,
            SliverFillRemaining(
              child: FoodSearchResultsList(foodManager: foodManager),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:foods_app/features/food_search/food_search.dart';
// import 'package:watch_it/watch_it.dart';
//
// class FoodSearchPage extends StatefulWidget {
//   const FoodSearchPage({super.key});
//
//   @override
//   State<FoodSearchPage> createState() => _FoodSearchPageState();
// }
//
// class _FoodSearchPageState extends State<FoodSearchPage> {
//   final foodManager = di.get<FoodSearchManager>();
//   final TextEditingController _searchTerm = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: CustomScrollView(slivers: [
//           SliverAppBar(
//             title: TextField(
//               controller: _searchTerm,
//             ),
//           ),
//           SliverFillRemaining(
//             child: FoodSearchResultsList(foodManager: foodManager),
//           ),
//         ]),
//       ),
//     );
//   }
// }
//
