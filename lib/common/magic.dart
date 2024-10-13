class DisplayMode {
  static const String light = 'light';

  static const String dark = 'dark';
  static const String system = 'system';
}

class LocatorName {
  static const String foodsDBService = 'foodsDBService';
  static const String sharedPrefsService = 'sharedPrefsService';
}

class AppStrings {
  static const searchPageHintText = 'Search for foods';
  static const detailsPageHintText = 'Search for comparison food';
  static const defaultQuickSearchString = '';
}

class AppNumbers {
  static const double foodDetailNutrientTile = 144;
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
}

class FoodDetailTileSize {
  static double s = 120;
  static double md = 136;
  static double lg = 152;
  static (double, double) tileSize({required double windowSize}) {
    switch (windowSize) {
      case <= BreakPoints.xs:
        return (s, Spacing.s);
      case <= BreakPoints.s:
        return (md, Spacing.md);
      case > BreakPoints.lg:
        return (lg, Spacing.lg);
      default:
        return (md, Spacing.md);
    }
  }
}
