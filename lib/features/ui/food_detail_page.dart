import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:foods_app/widgets/widgets.dart';
import 'package:watch_it/watch_it.dart';

class FoodDetailPage extends WatchingWidget {
  const FoodDetailPage({super.key});

  void _floatingButtonPressed(BuildContext context) {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute<FoodDetailPage>(
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

    final food = watchPropertyValue((FoodDetailManager m) => m.currentFood);
    // dev.log('$food');
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  floating: true,
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
                onPressed: () => _floatingButtonPressed(context),
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

class NutrientListItem extends StatelessWidget {
  const NutrientListItem({
    required this.food,
    required this.index,
    super.key,
  });

  final Food food;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: () {
          Navigator.of(context).push(
            CircularRangeSliderPopUp<void>(
              context: context,
              id: food.nutrientList[index].id,
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MagicSpacing.sp_4,
                    ),
                    child: AutoHyphenatingText(
                      textAlign: TextAlign.center,
                      food.nutrientList[index].name,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
              ],
            ),
            AmountWidget(
              id: food.nutrientList[index].id,
              textColor: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
    );
  }
}
