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
  static const int maxActiveFoodsAllowed = 6;
  static const double defaultIconStroke = 1.5;
  static const double defaultAmountWidgetIconSize = 18;
  static const double circularRangeFinderAmountWidgetIconSize = 48;
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
        return MagicTileDimension(dimension: xs, spacing: MagicSpacing.sp_1);
      case <= MagicBreakPoints.sm:
        return MagicTileDimension(dimension: sm, spacing: MagicSpacing.sp_3);
      case > MagicBreakPoints.lg:
        return MagicTileDimension(dimension: lg, spacing: MagicSpacing.sp_6);
      default:
        return MagicTileDimension(dimension: md, spacing: MagicSpacing.sp_4);
    }
  }
  static double xs = 108;
  static double sm = 112;
  static double md = 120;
  static double lg = 136;

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

/// A constant list of all nutrient names.
const List<String> nutrientNames = [
  'Protein',
  'Total Fat',
  'Total Carbohydrates',
  'Ash',
  'Calories',
  'Starch',
  'Sucrose',
  'Glucose (dextrose)',
  'Fructose',
  'Lactose',
  'Maltose',
  'Alcohol, ethyl',
  'Water',
  'Caffeine',
  'Theobromine',
  'Galactose',
  'Fiber, total dietary',
  'Calcium, Ca',
  'Iron, Fe',
  'Magnesium, Mg',
  'Phosphorus, P',
  'Potassium, K',
  'Sodium, Na',
  'Zinc, Zn',
  'Copper, Cu',
  'Fluoride, F',
  'Manganese, Mn',
  'Selenium, Se',
  'Vitamin A, IU',
  'Retinol',
  'Vitamin A, RAE',
  'Carotene, beta',
  'Carotene, alpha',
  'Vitamin E (alpha-tocopherol)',
  'Vitamin D (D2 + D3), International Units',
  'Vitamin D2 (ergocalciferol)',
  'Vitamin D3 (cholecalciferol)',
  'Vitamin D (D2 + D3)',
  'Cryptoxanthin, beta',
  'Lycopene',
  'Lutein + zeaxanthin',
  'Tocopherol, beta',
  'Tocopherol, gamma',
  'Tocopherol, delta',
  'Tocotrienol, alpha',
  'Tocotrienol, beta',
  'Tocotrienol, gamma',
  'Tocotrienol, delta',
  'Vitamin C, total ascorbic acid',
  'Thiamin',
  'Riboflavin',
  'Niacin',
  'Pantothenic acid',
  'Vitamin B-6',
  'Folate, total',
  'Vitamin B-12',
  'Choline, total',
  'Vitamin K (Menaquinone-4)',
  'Vitamin K (Dihydrophylloquinone)',
  'Vitamin K (phylloquinone)',
  'Folic acid',
  'Folate, food',
  'Folate, DFE',
  'Betaine',
  'Tryptophan',
  'Threonine',
  'Isoleucine',
  'Leucine',
  'Lysine',
  'Methionine',
  'Cystine',
  'Phenylalanine',
  'Tyrosine',
  'Valine',
  'Arginine',
  'Histidine',
  'Alanine',
  'Aspartic acid',
  'Glutamic acid',
  'Glycine',
  'Proline',
  'Serine',
  'Hydroxyproline',
  'Vitamin E, added',
  'Vitamin B-12, added',
  'Cholesterol',
  'Fatty acids, total trans',
  'Fatty acids, total saturated',
  '4:0',
  '6:0',
  '8:0',
  '10:0',
  '12:0',
  '14:0',
  '16:0',
  '18:0',
  '20:0',
  '18:1',
  '18:2',
  '18:3',
  '20:4',
  '22:6 n-3 (DHA)',
  '22:0',
  '14:1',
  '16:1',
  '18:4',
  '20:1',
  '20:5 n-3 (EPA)',
  '22:1',
  '22:5 n-3 (DPA)',
  'Phytosterols',
  'Stigmasterol',
  'Campesterol',
  'Beta-sitosterol',
  'Fatty acids, monounsaturated',
  'Fatty acids, polyunsaturated',
  '15:0',
  '17:0',
  '24:0',
  '16:1 t',
  '18:1 t',
  '22:1 t',
  '18:2 t not further defined',
  '18:2 i',
  '18:2 t,t',
  '18:2 CLAs',
  '24:1 c',
  '20:2 n-6 c,c',
  '16:1 c',
  '18:1 c',
  '18:2 n-6 c,c',
  '22:1 c',
  '18:3 n-6 c,c,c',
  '17:1',
  '20:3',
  'Fatty acids, total trans-monoenoic',
  'Fatty acids, total trans-polyenoic',
  '13:0',
  '15:1',
  '18:3 n-3 c,c,c (ALA)',
  '20:3 n-3',
  '20:3 n-6',
  '20:4 n-6',
  '18:3i',
  '21:5',
  '22:4',
  '18:1-11 t (18:1t n-7)',
  'Total Sugars',
];

Map<String, List<String>> nutrientCategories = {
  'Fats': [
    'Total Fat',
    'Cholesterol',
    'Fatty acids, total trans',
    'Fatty acids, total saturated',
    '4:0',
    '6:0',
    '8:0',
    '10:0',
    '12:0',
    '14:0',
    '16:0',
    '18:0',
    '20:0',
    '18:1',
    '18:2',
    '18:3',
    '20:4',
    '22:6 n-3 (DHA)',
    '22:0',
    '14:1',
    '16:1',
    '18:4',
    '20:1',
    '20:5 n-3 (EPA)',
    '22:1',
    '22:5 n-3 (DPA)',
    'Fatty acids, monounsaturated',
    'Fatty acids, polyunsaturated',
    '15:0',
    '17:0',
    '24:0',
    '16:1 t',
    '18:1 t',
    '22:1 t',
    '18:2 t not further defined',
    '18:2 i',
    '18:2 t,t',
    '18:2 CLAs',
    '24:1 c',
    '20:2 n-6 c,c',
    '16:1 c',
    '18:1 c',
    '18:2 n-6 c,c',
    '22:1 c',
    '18:3 n-6 c,c,c',
    '17:1',
    '20:3',
    'Fatty acids, total trans-monoenoic',
    'Fatty acids, total trans-polyenoic',
    '13:0',
    '15:1',
    '18:3 n-3 c,c,c (ALA)',
    '20:3 n-3',
    '20:3 n-6',
    '20:4 n-6',
    '18:3i',
    '21:5',
    '22:4',
    '18:1-11 t (18:1t n-7)',
  ],
  'Carbohydrates': [
    'Total Carbohydrates',
    'Starch',
    'Sucrose',
    'Glucose (dextrose)',
    'Fructose',
    'Lactose',
    'Maltose',
    'Galactose',
    'Fiber, total dietary',
    'Total Sugars',
  ],
  'Protein': [
    'Protein',
    'Tryptophan',
    'Threonine',
    'Isoleucine',
    'Leucine',
    'Lysine',
    'Methionine',
    'Cystine',
    'Phenylalanine',
    'Tyrosine',
    'Valine',
    'Arginine',
    'Histidine',
    'Alanine',
    'Aspartic acid',
    'Glutamic acid',
    'Glycine',
    'Proline',
    'Serine',
    'Hydroxyproline',
  ],
  'Vitamins': [
    'Vitamin A, IU',
    'Retinol',
    'Vitamin A, RAE',
    'Carotene, beta',
    'Carotene, alpha',
    'Vitamin E (alpha-tocopherol)',
    'Vitamin D (D2 + D3), International Units',
    'Vitamin D2 (ergocalciferol)',
    'Vitamin D3 (cholecalciferol)',
    'Vitamin D (D2 + D3)',
    'Cryptoxanthin, beta',
    'Lycopene',
    'Lutein + zeaxanthin',
    'Tocopherol, beta',
    'Tocopherol, gamma',
    'Tocopherol, delta',
    'Tocotrienol, alpha',
    'Tocotrienol, beta',
    'Tocotrienol, gamma',
    'Tocotrienol, delta',
    'Vitamin C, total ascorbic acid',
    'Thiamin',
    'Riboflavin',
    'Niacin',
    'Pantothenic acid',
    'Vitamin B-6',
    'Folate, total',
    'Vitamin B-12',
    'Choline, total',
    'Vitamin K (Menaquinone-4)',
    'Vitamin K (Dihydrophylloquinone)',
    'Vitamin K (phylloquinone)',
    'Folic acid',
    'Folate, food',
    'Folate, DFE',
    'Vitamin E, added',
    'Vitamin B-12, added',
  ],
  'Minerals': [
    'Calcium, Ca',
    'Iron, Fe',
    'Magnesium, Mg',
    'Phosphorus, P',
    'Potassium, K',
    'Sodium, Na',
    'Zinc, Zn',
    'Copper, Cu',
    'Fluoride, F',
    'Manganese, Mn',
    'Selenium, Se',
  ],
  'Other': [
    'Ash',
    'Calories',
    'Alcohol, ethyl',
    'Water',
    'Caffeine',
    'Theobromine',
    'Betaine',
    'Phytosterols',
    'Stigmasterol',
    'Campesterol',
    'Beta-sitosterol',
  ],
};
