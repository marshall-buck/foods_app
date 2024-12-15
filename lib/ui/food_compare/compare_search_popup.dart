import 'package:flutter/material.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/common/magic.dart';

import 'package:foods_app/ui/ui.dart';

class CompareSearchPopup<T> extends PopupRoute<T> {
  CompareSearchPopup({required this.context, required this.foodSearchManager});
  final BuildContext context;
  final _searchBarController = TextEditingController();
  final FoodSearchManager foodSearchManager;
  bool _showQuickResults = false;

  Future<void> _onChanged() async {
    await foodSearchManager.queryFoods(_searchBarController.text);
    setState(() {});
  }

  void _onClearSearch() {
    _searchBarController.clear();

    foodSearchManager.clearSearch();
    _showQuickResults = false;
  }

  bool _onScroll(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.axisDirection == AxisDirection.down) {
        // Scrolling down
        print('Scrolling Down');
      } else if (notification.metrics.axisDirection == AxisDirection.up) {
        // Scrolling up
        print('Scrolling Up');
      }
    }
    return true;
  }

  @override
  void dispose() {
    _searchBarController.dispose();

    super.dispose();
  }

  @override
  Color? get barrierColor => Theme.of(context)
      .colorScheme
      .primaryContainer
      .withValues(alpha: MagicOpacity.op_70);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    final height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.titleLarge!,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: height * .75),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(MagicSpacing.sp_8)),
              child: Padding(
                padding: const EdgeInsets.all(MagicSpacing.sp_4),
                child: Column(
                  spacing: MagicSpacing.sp_2,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: MagicSpacing.sp_3),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: MagicNumbers.maxSearchBarWidth,
                          minWidth: MagicNumbers.minSearchBarWidth,
                          maxHeight: MagicNumbers.searchBarHeight,
                          minHeight: MagicNumbers.searchBarHeight,
                        ),
                        child: SearchBar(
                          controller: _searchBarController,
                          constraints:
                              Theme.of(context).searchBarTheme.constraints,
                          hintText: MagicStrings.searchPageHintText,
                          trailing: [
                            if (foodSearchManager.hasResults)
                              const FoodResultsCountBadge()
                            else
                              const Spacer(),
                            IconButton(
                              onPressed: _onClearSearch,
                              icon: const Icon(Icons.clear_outlined),
                            ),
                          ],
                          onChanged: (string) => _onChanged(),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      // color: Colors.amber,
                      duration: MagicDurations.base1,
                      height: _showQuickResults ? 32 : 0,
                      child: const QuickResultsContainer(),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          final food = foodSearchManager.currentResults[index];

                          final id = ValueKey<int>(food!.id);
                          return GestureDetector(
                            onTap: () => {},
                            child: FoodListItem(
                              key: id,
                              food: food,
                            ),
                          );
                        },
                        itemCount: foodSearchManager.resultsCount,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
