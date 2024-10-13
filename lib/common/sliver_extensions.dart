import 'package:flutter/rendering.dart';

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
