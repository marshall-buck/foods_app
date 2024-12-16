import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/domain/domain.dart';
import 'package:foods_app/ui/core/nutrient_list_item.dart';

import 'package:foods_app/ui/ui.dart';
import 'package:watch_it/watch_it.dart';

class FoodDetailPage extends WatchingWidget {
  const FoodDetailPage({super.key});

  void _floatingButtonPressed(BuildContext context, Food food) {
    if (context.mounted) {
      di.get<FoodCompareManager>().addFoodToCompare(food: food);
      di.get<FoodSearchManager>().clearSearch();
      Navigator.push(
        context,
        MaterialPageRoute<FoodComparisonPage>(
          builder: (context) => const FoodComparisonPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    ///(dimension of a side, spacing)
    final tileSize = MagicTileDimension.tileSize(windowSize: width);

    // final food = watchPropertyValue((FoodDetailManager m) => m.currentFood);
    final food = di.get<AppHistoryState>().lastFood;
    callOnce(
      (_) => di.get<FoodAmountManager>().initAmountStrings(food!),
      dispose: () => di.get<FoodAmountManager>().clearAmounts(),
    );
    // dev.log('$food');
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: _MySliverHeaderDelegate(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: tileSize.spacing),
                      child: FoodDescriptionCard(
                        tileSize: tileSize,
                        food: food!,
                      ),
                    ),
                    maxHeight: tileSize.dimension,
                    minHeight: 100,
                  ),
                ),
                _NutrientGrid(tileSize: tileSize, food: food),
              ],
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                child: const Icon(Icons.compare),
                onPressed: () => _floatingButtonPressed(context, food),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MySliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _MySliverHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: MagicNumbers.maxFoodDetailWidth),
        child: child,
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _NutrientGrid extends StatelessWidget {
  const _NutrientGrid({
    required this.tileSize,
    required this.food,
  });

  final MagicTileDimension tileSize;
  final Food food;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(tileSize.spacing * 2),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: tileSize.dimension,
          crossAxisSpacing: tileSize.spacing,
          mainAxisSpacing: tileSize.spacing,
        ),
        itemCount: food.nutrientList.length,
        itemBuilder: (BuildContext context, int index) {
          final nutrientKey = Key('${food.id}:${food.nutrientList[index].id}');
          return ClipOval(
            child: NutrientListItem(key: nutrientKey, food: food, index: index),
          );
        },
      ),
    );
  }
}
