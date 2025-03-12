class DisplayMode {
  static const String light = 'light';

  static const String dark = 'dark';
  static const String system = 'system';
}

class LocatorInstanceNames {
  static const String foodsDBService = 'foodsDBService';
  static const String sharedPrefsService = 'sharedPrefsService';
}

class MagicStrings {
  static const searchPageHintText = 'Search for foods';
  static const compareSearchBarText = 'Search for food to compare';
  static const defaultQuickSearchString = '';
  static const searchBarHeroTag = 'search-bar';
}

class MagicNumbers {
  static const double maxSearchBarWidth = 720;
  static const double minSearchBarWidth = 360;
  static const double maxFoodDetailWidth = 360;
  static const double searchBarHeight = 56;

  static const double defaultFoodAmount = 100;
  static const int defaultSearchHistory = 10;
  static const double circularRangeSliderTrackStroke = 8;
  static const double circularRangeSliderHandleRadius = 16;
  static const double circularRangeSliderTrackDiameter = 200;

  static const int maxFoodSearchCacheAmount = 500;
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

class MagicBorderRadius {
  static const double br_0 = 0;
  static const double br_1 = 4;
  static const double br_2 = 8;
  static const double br_3 = 12;
  static const double br_4 = 16;
  static const double br_5 = 20;
  static const double br_6 = 24;
  static const double br_7 = 28;
  static const double br_8 = 32;
  static const double br_9 = 36;
  static const double br_10 = 40;
  static const double br_11 = 44;
  static const double br_12 = 48;
  static const double br_14 = 56;
  static const double br_16 = 64;
  static const double br_20 = 80;
  static const double br_24 = 96;
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
        return MagicTileDimension(dimension: md, spacing: MagicSpacing.sp_1);
      case <= MagicBreakPoints.sm:
        return MagicTileDimension(dimension: md, spacing: MagicSpacing.sp_3);
      case > MagicBreakPoints.lg:
        return MagicTileDimension(dimension: lg, spacing: MagicSpacing.sp_6);
      default:
        return MagicTileDimension(dimension: md, spacing: MagicSpacing.sp_4);
    }
  }
  // static double xs = 120;
  // static double sm = 136;
  static double md = 144;
  static double lg = 160;

  final double dimension;
  final double spacing;
}

class MagicOpacity {
  static const double op_0 = 0;
  static const double op_5 = 0.05;
  static const double op_10 = 0.1;
  static const double op_20 = 0.2;
  static const double op_25 = 0.25;
  static const double op_30 = 0.3;
  static const double op_40 = 0.4;
  static const double op_50 = 0.5;
  static const double op_60 = 0.6;
  static const double op_70 = 0.7;
  static const double op_75 = 0.75;
  static const double op_80 = 0.8;
  static const double op_90 = 0.9;
  static const double op_95 = 0.95;
  static const double op_100 = 1;
}

class MagicBlurRadius {
  static const double blur_0 = 0;
  static const double blur_1 = 1;
  static const double blur_2 = 2;
  static const double blur_3 = 3;
  static const double blur_4 = 4;
  static const double blur_5 = 5;
  static const double blur_6 = 6;
  static const double blur_7 = 7;
  static const double blur_8 = 8;
  static const double blur_9 = 9;
  static const double blur_10 = 10;
  static const double blur_11 = 11;
  static const double blur_12 = 12;
  static const double blur_14 = 14;
  static const double blur_16 = 16;
  static const double blur_20 = 20;
  static const double blur_24 = 24;
}
