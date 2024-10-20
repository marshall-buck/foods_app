import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class CustomFoodDetailSliverGridDelegate extends SliverGridDelegate {
  CustomFoodDetailSliverGridDelegate({
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
  bool shouldRelayout(CustomFoodDetailSliverGridDelegate oldDelegate) {
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
