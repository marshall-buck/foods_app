// import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/circular_range_slider_detector.dart';

import 'package:watch_it/watch_it.dart';

class FoodDetail extends WatchingStatefulWidget {
  const FoodDetail({super.key});

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    ///(dimension of a side, spacing)
    final tileSize = MagicTileDimension.tileSize(windowSize: width);

    final food = watchValue((FoodDetailManager m) => m.currentFood);
    return Material(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              floating: true,
              delegate: _MySliverHeaderDelegate(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: tileSize.spacing),
                  child: FoodDescriptionCard(
                    tileSize: tileSize,
                    food: food!,
                  ),
                ),
                maxHeight: tileSize.dimension,
                minHeight: 100,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(tileSize.spacing * 2),
              sliver: SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: tileSize.dimension,
                  crossAxisSpacing: tileSize.spacing,
                  mainAxisSpacing: tileSize.spacing,
                  // mainAxisExtent: tileSize.dimension / 2,
                ),
                itemCount: food.nutrientList.length,
                itemBuilder: (BuildContext context, int index) {
                  return NutrientListItem(food: food, index: index);
                },
              ),
            ),
          ],
        ),
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
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Text(
        food.nutrientList[index].name,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

class FoodDescriptionCard extends StatelessWidget {
  const FoodDescriptionCard({
    required this.tileSize,
    required this.food,
    super.key,
  });

  final MagicTileDimension tileSize;
  final Food food;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          const BoxConstraints(maxWidth: MagicDimensions.maxSearchBarWidth),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(MagicSpacing.sp_4),
        ),

        // width: double.infinity,
        height: tileSize.dimension - MagicSpacing.sp_6,
        child: Row(
          children: [
            const CircularRangeSliderDetector(isAdjustable: false),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(MagicSpacing.sp_2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      food.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.save_as),
                        Icon(Icons.edit),
                        Icon(Icons.refresh),
                      ],
                    ),
                  ],
                ),
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
    return SizedBox.expand(
      child: child,
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
