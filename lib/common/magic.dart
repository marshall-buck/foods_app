class DisplayMode {
  static const String light = 'light';

  static const String dark = 'dark';
  static const String system = 'system';
}

class LocatorName {
  static const String foodsDBService = 'foodsDBService';
  static const String sharedPrefsService = 'sharedPrefsService';
}

class MagicStrings {
  static const searchPageHintText = 'Search for foods';
  static const detailsPageHintText = 'Search for comparison food';
  static const defaultQuickSearchString = '';
  static const searchBarHeroTag = 'search-bar';
}

class MagicNumbers {
  static const double maxSearchBarWidth = 590;
}

class BreakPoints {
  static const double xs = 450;
  static const double s = 600;
  static const double md = 840;
  static const double lg = 1200;
}

class Spacing {
  static const double xs = 4;
  static const double s = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
}

class FoodDetailTileSize {
  static double s = 128;
  static double md = 144;
  static double lg = 160;
  static (double, double) tileSize({required double windowSize}) {
    switch (windowSize) {
      case <= BreakPoints.xs:
        return (s, Spacing.md);
      case <= BreakPoints.s:
        return (md, Spacing.lg);
      case > BreakPoints.lg:
        return (lg, Spacing.xl);
      default:
        return (md, Spacing.lg);
    }
  }
}
