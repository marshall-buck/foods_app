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
  static const double maxSearchBarWidth = 720;
  static const double minSearchBarWidth = 720;
  static const double searchBarHeight = 56;
}

class BreakPoints {
  static const double xs = 450;
  static const double sm = 600;
  static const double md = 840;
  static const double lg = 1200;
}

class Spacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
}

class AppDurations {
  static const base0 = Duration(milliseconds: 200);
  static const base1 = Duration(milliseconds: 330);
  static const base2 = Duration(milliseconds: 460);
}

class FoodDetailTileSize {
  static double xs = 112;
  static double sm = 128;
  static double md = 144;
  static double lg = 160;
  static (double, double) tileSize({required double windowSize}) {
    switch (windowSize) {
      case <= BreakPoints.xs:
        return (md, Spacing.xs);
      case <= BreakPoints.sm:
        return (md, Spacing.sm);
      case > BreakPoints.lg:
        return (lg, Spacing.xl);
      default:
        return (md, Spacing.lg);
    }
  }
}
