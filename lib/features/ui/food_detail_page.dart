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

  // final _scrollController = ScrollController();

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
            // padding: const EdgeInsets.all(12.0),
            gridDelegate: CustomSliverGridDelegate(),
            // Try uncommenting some of these properties to see the effect on
            //the grid:
            itemCount:
                50, // The default is that the number of grid tiles is infinite.
            itemBuilder: (BuildContext context, int index) {
              // final math.Random random = math.Random(index);
              return Placeholder(
                child: Text('$index'),
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

class CustomSliverGridDelegate extends SliverGridDelegate {
  CustomSliverGridDelegate({this.minSpacing = 5});

  final double minSpacing;

  /// Returns information about the size and position of the tiles in the grid.
  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    // Determine how many squares we can fit per row.
    final count = constraints.crossAxisExtent ~/ (144 + minSpacing);
    final width = constraints.crossAxisExtent;

    constraints.printConstraints();
    return CustomSliverGridLayout(
        crossAxisCount: count,
        mainAxisStride: 144 + minSpacing,
        crossAxisStride: 144 + minSpacing,
        childMainAxisExtent: 144,
        childCrossAxisExtent: 144,
        reverseCrossAxis: false,
        gridViewWidth: width,
        minSpacing: minSpacing);
  }

  @override
  bool shouldRelayout(CustomSliverGridDelegate oldDelegate) {
    return true;
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
        assert(gridViewWidth >= 0, 'Error in CustomGridLayout gridViewWidth');

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

  /// The minimum child index that intersects with (or is after) this scroll offset.
  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    return mainAxisStride > precisionErrorTolerance
        ? crossAxisCount * (scrollOffset ~/ mainAxisStride)
        : 0;
  }

  /// The maximum child index that intersects with (or is before) this scroll offset.
  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    if (mainAxisStride > 0.0) {
      final int mainAxisCount = (scrollOffset / mainAxisStride).ceil();
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
    final double crossAxisStart = (index % crossAxisCount) * crossAxisStride +
        (leftover.abs() + (minSpacing / 2));
    print(
        'INDEX MOD crossAxisCount: ${index % crossAxisCount} \n ${leftover.abs()}');
    //final double crossAxisStart = (index % crossAxisCount) * crossAxisStride;

    final geo = SliverGridGeometry(
      scrollOffset: (index ~/ crossAxisCount) * mainAxisStride,
      crossAxisOffset: _getOffsetFromStartInCrossAxis(crossAxisStart),
      mainAxisExtent: childMainAxisExtent,
      crossAxisExtent: childCrossAxisExtent,
    );

    print('getGeometryForChildIndex - INDEX: $index');
    print('getGeometryForChildIndex - crossAxisCount: $crossAxisCount');

    print('getGeometryForChildIndex - mainAxisStride: $mainAxisStride');

    print('getGeometryForChildIndex - crossAxisStride: $crossAxisStride');

    print(
        'getGeometryForChildIndex - childMainAxisExtent: $childMainAxisExtent');

    print(
        'getGeometryForChildIndex - childCrossAxisExtent: $childCrossAxisExtent');

    print('getGeometryForChildIndex - reverseCrossAxis: $reverseCrossAxis');
    print('GEO: $geo');
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
      return 0.0;
    }
    final int mainAxisCount = ((childCount - 1) ~/ crossAxisCount) + 1;
    final double mainAxisSpacing = mainAxisStride - childMainAxisExtent;
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
