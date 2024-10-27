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

class MagicDimensions {
  static const double maxSearchBarWidth = 720;
  static const double minSearchBarWidth = 720;
  static const double searchBarHeight = 56;
  static const double baseRadius = 16;
}

class MagicBreakPoints {
  static const double xs = 450;
  static const double sm = 600;
  static const double md = 840;
  static const double lg = 1200;
}

class MagicSpacing {
  static const double sp_0 = 0;
  static const double sp_1 = 4;
  static const double sp_2 = 8;
  static const double sp_3 = 12;
  static const double sp_4 = 16;
  static const double sp_5 = 20;
  static const double sp_6 = 24;
  static const double sp_7 = 28;
  static const double sp_8 = 32;
  static const double sp_9 = 36;
  static const double sp_10 = 40;
  static const double sp_11 = 44;
  static const double sp_12 = 48;
  static const double sp_14 = 56;
  static const double sp_16 = 64;
  static const double sp_20 = 80;
  static const double sp_24 = 96;
}

class MagicDurations {
  static const base0 = Duration(milliseconds: 200);
  static const base1 = Duration(milliseconds: 330);
  static const base2 = Duration(milliseconds: 460);
}

class MagicTileDimension {
  const MagicTileDimension({required this.dimension, required this.spacing});

  ///  (dimension of a side, spacing)
  factory MagicTileDimension.tileSize({required double windowSize}) {
    switch (windowSize) {
      case <= MagicBreakPoints.xs:
        return MagicTileDimension(dimension: md, spacing: MagicSpacing.sp_3);
      case <= MagicBreakPoints.sm:
        return MagicTileDimension(dimension: md, spacing: MagicSpacing.sp_2);
      case > MagicBreakPoints.lg:
        return MagicTileDimension(dimension: lg, spacing: MagicSpacing.sp_6);
      default:
        return MagicTileDimension(dimension: md, spacing: MagicSpacing.sp_4);
    }
  }
  static double xs = 112;
  static double sm = 128;
  static double md = 144;
  static double lg = 160;

  final double dimension;
  final double spacing;
}
