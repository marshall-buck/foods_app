// import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';

import 'package:watch_it/watch_it.dart';

class FoodDetailPage extends WatchingWidget {
  const FoodDetailPage({super.key});

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
            _NutrientGrid(tileSize: tileSize, food: food),
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
            const BoxConstraints(maxWidth: MagicDimensions.maxFoodDetailWidth),
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(MagicSpacing.sp_4),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .colorScheme
                .shadow
                .withOpacity(MagicOpacity.op_50),
            blurRadius: MagicBlurRadius.blur_5,
            offset: const Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      height: tileSize.dimension,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: GestureDetector(
              onLongPress: () {
                Navigator.of(context).push(
                  CircularRangeSliderPopUp<void>(
                    context: context,
                    id: food.id,
                  ),
                );
              },
              child: AmountWidget(
                id: food.id,
                textColor: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
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
    );
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
          return NutrientListItem(key: nutrientKey, food: food, index: index);
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
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    food.nutrientList[index].name,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: GestureDetector(
              onLongPress: () {
                Navigator.of(context).push(
                  CircularRangeSliderPopUp<void>(
                    context: context,
                    id: food.nutrientList[index].id,
                  ),
                );
              },
              child: AmountWidget(
                id: food.nutrientList[index].id,
                textColor: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AmountWidget extends WatchingWidget {
  const AmountWidget({
    required this.textColor,
    required this.id,
    super.key,
  });
  final Color textColor;
  final num id;

  @override
  Widget build(BuildContext context) {
    // dev.log(
    //   '$id : ${id.runtimeType}',
    //   name: 'AmountWidget id : id.runtimeType',
    // );

    final amountStrings =
        watchPropertyValue((FoodDetailManager m) => m.amountStrings);
    // dev.log(
    //   '$id :  ${amount[id]}',
    //   name: 'AmountWidget amount[id] : value',
    // );
    return Center(
      child: Text(
        amountStrings[id]?.$2 ?? '',
        style:
            Theme.of(context).textTheme.titleMedium!.copyWith(color: textColor),
      ),
    );
  }
}
