import 'dart:math' as math;
import 'package:flutter/foundation.dart';
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
  final _textFieldKey = GlobalKey<FoodsAppSearchBarState>();

  Future<void> _clearSearch() async {
    // await foodManager.clearSearch();
    _textFieldKey.currentState?.clearSearch();
  }

  final _scrollController = ScrollController();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // print(properties.properties);
    super.debugFillProperties(properties);
  }

  @override
  void initState() {
    super.initState();
  }

  late final Widget appBar = SliverPadding(
    padding: const EdgeInsets.only(bottom: 4),
    sliver: CustomSliverAppBar(
      textFieldKey: _textFieldKey,
      onClearSearch: _clearSearch,
      showBadge: false,
      hintText: AppStrings.detailsPageHintText,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final tileSize = FoodDetailTileSize.tileSize(windowSize: width);
    // print('_FoodDetailState window tileSize: $tileSize');
    final food = watchValue((FoodDetailManager m) => m.currentFood);
    return NotificationListener<FoodsAppSearchBarNotification>(
      onNotification: (notification) {
        return true;
      },
      child: BasePage(
        slivers: [
          appBar,
          FoodDetailDescription(food: food!),
          SliverGrid.builder(
            gridDelegate: FoodDetailSliverGridDelegate(
              minSpacing: tileSize.$2,
              dimension: tileSize.$1,
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
  });

  final double minSpacing;
  final double dimension;
  late int count;

  /// Returns information about the size and position of the tiles in the grid.
  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    // Determine how many squares we can fit per row.
    count = constraints.crossAxisExtent ~/ (dimension + minSpacing);
    final width = constraints.crossAxisExtent;

    // constraints.printConstraints();
    return CustomSliverGridLayout(
      crossAxisCount: count,
      mainAxisStride: dimension + minSpacing,
      crossAxisStride: dimension + minSpacing,
      childMainAxisExtent: dimension,
      childCrossAxisExtent: dimension,
      reverseCrossAxis: false,
      gridViewWidth: width,
      minSpacing: minSpacing,
    );
  }

  @override
  bool shouldRelayout(FoodDetailSliverGridDelegate oldDelegate) {
    return dimension != oldDelegate.dimension;
  }
}

class CustomSliverGridLayout extends SliverGridLayout {
  const CustomSliverGridLayout({
    required this.crossAxisCount,
    required this.mainAxisStride,
    required this.crossAxisStride,
    required this.childMainAxisExtent,
    required this.childCrossAxisExtent,
    required this.reverseCrossAxis,
    required this.gridViewWidth,
    required this.minSpacing,
  })  : assert(crossAxisCount > 0, 'Error in CustomGridLayout crossAxisCount'),
        assert(mainAxisStride >= 0, 'Error in CustomGridLayout mainAxisStride'),
        assert(
          crossAxisStride >= 0,
          'Error in CustomGridLayout crossAxisStride',
        ),
        assert(
          childMainAxisExtent >= 0,
          'Error in CustomGridLayout childMainAxisExtent',
        ),
        assert(
          childCrossAxisExtent >= 0,
          'Error in CustomGridLayout childCrossAxisExtent',
        ),
        assert(gridViewWidth >= 0, 'Error in CustomGridLayout gridViewWidth'),
        assert(minSpacing >= 0, 'Error in CustomGridLayout minSpacing');

  /// The number of children in the cross axis.
  final int crossAxisCount;

  /// The number of pixels from the leading edge of one tile to the leading edge
  /// of the NEXT tile in the main axis.
  final double mainAxisStride;

  /// The number of pixels from the leading edge of one tile to the leading edge
  /// of the NEXT tile in the cross axis.
  final double crossAxisStride;

  /// The number of pixels from the leading edge of one tile to the trailing
  /// edge of the SAME tile in the main axis.
  final double childMainAxisExtent;

  /// The number of pixels from the leading edge of one tile to the trailing
  /// edge of the SAME tile in the cross axis.
  final double childCrossAxisExtent;

  /// Whether the children should be placed in the opposite order of increasing
  /// coordinates in the cross axis.
  ///
  /// For example, if the cross axis is horizontal, the children are placed from
  /// left to right when [reverseCrossAxis] is false and from right to left when
  /// [reverseCrossAxis] is true.
  ///
  /// Typically set to the return value of [axisDirectionIsReversed] applied to
  /// the [SliverConstraints.crossAxisDirection].
  final bool reverseCrossAxis;

  final double gridViewWidth;

  final double minSpacing;

  /// The minimum child index that intersects with (or is after)
  /// this scroll offset.
  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    return mainAxisStride > precisionErrorTolerance
        ? crossAxisCount * (scrollOffset ~/ mainAxisStride)
        : 0;
  }

  /// The maximum child index that intersects with (or is before)
  /// this scroll offset.
  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    if (mainAxisStride > 0.0) {
      final mainAxisCount = (scrollOffset / mainAxisStride).ceil();
      return math.max(0, crossAxisCount * mainAxisCount - 1);
    }
    return 0;
  }

  double _getOffsetFromStartInCrossAxis(double crossAxisStart) {
    if (reverseCrossAxis) {
      return crossAxisCount * crossAxisStride -
          crossAxisStart -
          childCrossAxisExtent -
          (crossAxisStride - childCrossAxisExtent);
    }
    return crossAxisStart;
  }

  /// The size and position of the child with the given index.
  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    final leftover = ((mainAxisStride * crossAxisCount) - gridViewWidth) / 2;
    final crossAxisStart = (index % crossAxisCount) * crossAxisStride +
        (leftover.abs() + (minSpacing / 2));
    // print(
    //   // ignore: lines_longer_than_80_chars
    //   'INDEX MOD crossAxisCount: ${index % crossAxisCount} \n ${leftover.abs()}',
    // );

    final geo = SliverGridGeometry(
      scrollOffset: (index ~/ crossAxisCount) * mainAxisStride,
      crossAxisOffset: _getOffsetFromStartInCrossAxis(crossAxisStart),
      mainAxisExtent: childMainAxisExtent,
      crossAxisExtent: childCrossAxisExtent,
    );

    // print('getGeometryForChildIndex - INDEX: $index');
    // print('getGeometryForChildIndex - crossAxisCount: $crossAxisCount');

    // print('getGeometryForChildIndex - mainAxisStride: $mainAxisStride');

    // print('getGeometryForChildIndex - crossAxisStride: $crossAxisStride');

    // print(
    //   'getGeometryForChildIndex - childMainAxisExtent: $childMainAxisExtent',
    // );

    // print(
    //   'getGeometryForChildIndex - childCrossAxisExtent: $childCrossAxisExtent',
    // );

    // print('getGeometryForChildIndex - reverseCrossAxis: $reverseCrossAxis');
    // print('GEO: $geo');
    return geo;
  }

  /// The scroll extent needed to fully display all the tiles if there are
  /// `childCount` children in total.
  ///
  /// The child count will never be null.
  @override
  double computeMaxScrollOffset(int childCount) {
    if (childCount == 0) {
      // There are no children in the grid. The max scroll offset should be
      // zero.
      return 0;
    }
    final mainAxisCount = ((childCount - 1) ~/ crossAxisCount) + 1;
    final mainAxisSpacing = mainAxisStride - childMainAxisExtent;
    return mainAxisStride * mainAxisCount - mainAxisSpacing;
  }
}

extension SliverConstraintsDebug on SliverConstraints {
  void printConstraints() {
    debugPrint('''
SliverConstraints(
  axisDirection: $axisDirection,
  growthDirection: $growthDirection,
  userScrollDirection: $userScrollDirection,
  scrollOffset: $scrollOffset,
  precedingScrollExtent: $precedingScrollExtent,
  overlap: $overlap,
  remainingPaintExtent: $remainingPaintExtent,
  crossAxisExtent: $crossAxisExtent,
  crossAxisDirection: $crossAxisDirection,
  viewportMainAxisExtent: $viewportMainAxisExtent,
  remainingCacheExtent: $remainingCacheExtent,
  cacheOrigin: $cacheOrigin,
)
''');
  }
}
