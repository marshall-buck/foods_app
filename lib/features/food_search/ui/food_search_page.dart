import 'package:flutter/material.dart';
import 'package:foods_app/features/food_search/food_search.dart';
import 'package:watch_it/watch_it.dart';

class FoodSearchPage extends StatefulWidget {
  const FoodSearchPage({super.key});

  @override
  State<FoodSearchPage> createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends State<FoodSearchPage> {
  final foodManager = di.get<FoodSearchManager>();
  final TextEditingController _searchTerm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverAppBar(
            title: TextField(
              controller: _searchTerm,
            ),
          ),
          SliverFillRemaining(
            child: FoodSearchResultsList(foodManager: foodManager),
          ),
        ]),
      ),
    );
  }
}
