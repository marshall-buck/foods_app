import 'package:flutter/material.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:watch_it/watch_it.dart';

class HomePage extends WatchingStatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  final _searchBarController = TextEditingController();
  //
  Future<void> _onChanged(String string) async {
    await di.get<FoodSearchManager>().queryFoods(_searchBarController.text);
  }

  void _onClearSearch() {
    _searchBarController.clear();
    di.get<FoodSearchManager>().clearSearch();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = watchValue((FoodSearchManager e) => e.currentResults);
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
              child: AnimatedAlign(
                duration: AppDurations.base1,
                alignment:
                    results.isNotEmpty ? Alignment.topCenter : Alignment.center,
                child: SearchBar(
                  controller: _searchBarController,
                  constraints: Theme.of(context).searchBarTheme.constraints,
                  hintText: MagicStrings.searchPageHintText,
                  trailing: [
                    IconButton(
                      onPressed: _onClearSearch,
                      icon: const Icon(Icons.clear_outlined),
                    ),
                  ],
                  onChanged: _onChanged,
                ),
              ),
            ),
            const Expanded(
                child: Padding(
              padding: EdgeInsets.only(top: 56),
              child: FoodsList(),
            ))
          ],
        ),
      ),
    );
  }
}
