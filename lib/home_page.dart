import 'package:flutter/material.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';
import 'package:watch_it/watch_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hasSearchResults = false;

  Future<void> _onChanged(BuildContext context, String string) async {
    di.get<FoodSearchManager>().updateSearch(string);

    await di.get<FoodSearchManager>().queryFoods();

    if (di.get<FoodSearchManager>().currentResults.value.isNotEmpty) {
      setState(() {
        _hasSearchResults = true;
      });
    }
  }

  void _onClearSearch() {
    di.get<FoodSearchManager>().clearSearch();
  }

  @override
  void initState() {
    if (di.get<FoodSearchManager>().currentResults.value.isNotEmpty) {
      _hasSearchResults = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
          child: Align(
            child: AnimatedContainer(
              height: _hasSearchResults
                  ? MediaQuery.sizeOf(context).height
                  : MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(32),
              ),
              duration: const Duration(milliseconds: 330),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 330),
                  alignment: _hasSearchResults
                      ? Alignment.topCenter
                      : Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: _hasSearchResults ? 24 : 0),
                    child: SearchBar(
                      constraints: Theme.of(context).searchBarTheme.constraints,
                      hintText: MagicStrings.searchPageHintText,
                      trailing: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IconButton(
                            onPressed: _onClearSearch,
                            icon: const Icon(Icons.clear_outlined),
                          ),
                        ),
                      ],
                      // showBadge: false,
                      // onClearSearch: _onClearSearch,
                      onChanged: (String string) {
                        _onChanged(context, string);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
