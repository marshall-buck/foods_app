import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

enum Breakpoint { xs, sm, md, lg }

class ResponsiveUtils {
  static Breakpoint getBreakpoint(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    if (screenWidth <= MagicBreakPoints.xs) {
      return Breakpoint.xs;
    } else if (screenWidth <= MagicBreakPoints.sm) {
      return Breakpoint.sm;
    } else if (screenWidth <= MagicBreakPoints.md) {
      return Breakpoint.md;
    } else {
      return Breakpoint.lg;
    }
  }

  static bool isXs(BuildContext context) => getBreakpoint(context) == Breakpoint.xs;

  static bool isSm(BuildContext context) => getBreakpoint(context) == Breakpoint.sm;

  static bool isMd(BuildContext context) => getBreakpoint(context) == Breakpoint.md;

  static bool isLg(BuildContext context) => getBreakpoint(context) == Breakpoint.lg;
}
