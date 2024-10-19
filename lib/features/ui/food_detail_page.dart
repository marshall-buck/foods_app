import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';

import 'package:watch_it/watch_it.dart';

class FoodDetail extends WatchingStatefulWidget {
  const FoodDetail({super.key});

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // print(properties.properties);
    super.debugFillProperties(properties);
  }

  @override
  void initState() {
    super.initState();
  }

  late final Widget appBar = const SliverPadding(
    padding: EdgeInsets.only(bottom: 4),
    sliver: CustomSliverAppBar(
      showBadge: false,
      hintText: MagicStrings.detailsPageHintText,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final tileSize = FoodDetailTileSize.tileSize(windowSize: width);
    // print('_FoodDetailState window tileSize: $tileSize');
    final food = watchValue((FoodDetailManager m) => m.currentFood);
    return BasePage(
      child: CustomScrollView(
        slivers: [
          appBar,
          FoodDetailDescription(food: food!),
          SliverGrid.builder(
            gridDelegate: FoodDetailSliverGridDelegate(
              minSpacing: tileSize.$2,
              dimension: tileSize.$1,
              center: true,
            ),
            itemCount: food.nutrients.length,
            itemBuilder: (BuildContext context, int index) {
              return Placeholder(
                child: Text(food.description),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FoodDetailDescription extends StatelessWidget {
  const FoodDetailDescription({required this.food, super.key});
  final Food food;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: FoodsAppThemeExtension.of(context).primaryContainer,
        ),
        width: double.infinity,
        height: 128,
        child: const Row(
          children: [
            Expanded(child: Placeholder()),
            Expanded(flex: 2, child: Placeholder()),
          ],
        ),
      ),
    );
  }
}

class FoodDetailSliverGridDelegate extends SliverGridDelegate {
  FoodDetailSliverGridDelegate({
    required this.minSpacing,
    required this.dimension,
    this.center = false,
  });

  final double minSpacing;
  final double dimension;
  late int count;
  bool center;

  /// Returns information about the size and position of the tiles in the grid.
  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    // Determine how many squares we can fit per row.
    count = constraints.crossAxisExtent ~/ (dimension + minSpacing);
    final width = constraints.crossAxisExtent;

    final totalFilledSpace = count * dimension;
    final leftOverSpace = width - totalFilledSpace;
    final centeredSpacing = leftOverSpace / (count + 1);

    // constraints.printConstraints();
    return CustomSliverGridLayout(
      crossAxisCount: count,
      mainAxisStride: center == false
          ? dimension + minSpacing
          : dimension + centeredSpacing,
      crossAxisStride: center == false
          ? dimension + minSpacing
          : dimension + centeredSpacing,
      childMainAxisExtent: dimension,
      childCrossAxisExtent: dimension,
      reverseCrossAxis: false,
      gridViewWidth: width,
      minSpacing: center == false ? minSpacing : centeredSpacing,
    );
  }

  @override
  bool shouldRelayout(FoodDetailSliverGridDelegate oldDelegate) {
    return dimension != oldDelegate.dimension;
  }
}
