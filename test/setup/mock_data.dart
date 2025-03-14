// ignore_for_file: lines_longer_than_80_chars

import 'package:foods_app/data/data.dart';
import 'package:usda_db_package/usda_db_package.dart';

const protein = NutrientDTO(id: 1003, amount: 20, unit: 'g', name: 'Protein');
const totalFat = NutrientDTO(id: 1004, amount: 15, unit: 'g', name: 'Total Fat');
const totalCarbs = NutrientDTO(
  id: 1005,
  amount: 30,
  unit: 'g',
  name: 'Total Carbohydrates',
);
const water = NutrientDTO(id: 1051, amount: 500, unit: 'g', name: 'Water');
const totalSugars = NutrientDTO(
  id: 2000,
  amount: 10,
  unit: 'g',
  name: 'Total Sugars',
);

const food1 = FoodDTO(
  id: 167512,
  description: 'Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough',
  nutrients: {
    1003: 5.88,
    1079: 1.2,
    1258: 2.94,
    1004: 13.2,
    1005: 41.2,
    1008: 307,
    2000: 5.88,
  },
);

final food2 = FoodDTO.fromUsdaFoodModel(
  const UsdaFoodModel(
    id: 167516,
    description: 'Waffles, buttermilk, frozen, ready-to-heat',
    nutrients: {
      1258: 1.9,
      1003: 6.58,
      1079: 2.2,
      1008: 273,
      2000: 4.3,
      1004: 9.22,
      1005: 41.0,
    },
  ),
);

const mockFoodsData = {
  167512: {
    'description': 'Pillsbury Golden Layer Buttermilk Biscuits, Artificial Flavor, refrigerated dough',
    'nutrients': {
      1003: 5.88,
      1079: 1.2,
      1258: 2.94,
      1004: 13.2,
      1005: 41.2,
      1008: 307,
      2000: 5.88,
    },
  },
  167513: {
    'description': 'Pillsbury, Cinnamon Rolls with Icing, refrigerated dough',
    'nutrients': {
      1003: 4.34,
      1079: 1.4,
      1258: 3.25,
      1004: 11.3,
      1005: 53.4,
      1008: 330,
      2000: 21.3,
    },
  },
  167514: {
    'description': 'Kraft Foods, Shake N Bake Original Recipe, Coating for Pork, dry',
    'nutrients': {
      1004: 3.7,
      1005: 79.8,
      1008: 377,
      1003: 6.1,
    },
  },
  167515: {
    'description': 'George Weston Bakeries, Thomas English Muffins',
    'nutrients': {
      1258: 0.308,
      1003: 8.0,
      1004: 1.8,
      1005: 46.0,
      1008: 232,
    },
  },
  167516: {
    'description': 'Waffles, buttermilk, frozen, ready-to-heat',
    'nutrients': {
      1258: 1.9,
      1003: 6.58,
      1079: 2.2,
      1008: 273,
      2000: 4.3,
      1004: 9.22,
      1005: 41.0,
    },
  },
  167517: {
    'description': 'Waffle, buttermilk, frozen, ready-to-heat, toasted',
    'nutrients': {
      1258: 2.28,
      1004: 9.49,
      1005: 48.4,
      1008: 309,
      2000: 4.41,
      1003: 7.42,
      1079: 2.6,
    },
  },
};

/* cSpell:disable */
const Map<String, List<int>> mockUnHashedSubstrings = {
  '2%': [3],
  '21': [3, 4],
  'ab': [3, 4],
  'aba': [3, 4],
  'abap': [3, 4],
  'abapp': [3, 4],
  'abappl': [3, 4],
  'abapple': [3, 4],
  'ap': [1, 2, 3, 4],
  'app': [1, 2, 3, 4],
  'appl': [1, 2, 3, 4],
  'apple': [1, 2, 3, 4],
  'ba': [3, 4],
  'bap': [3, 4],
  'bapp': [3, 4],
  'bappl': [3, 4],
  'bapple': [3, 4],
  'cr': [3, 4],
  'cra': [3, 4],
  'crab': [3, 4],
  'craba': [3, 4],
  'crabap': [3, 4],
  'crabapp': [3, 4],
  'crabappl': [3, 4],
  'crabapple': [3, 4],
  'le': [1, 2, 3, 4],
  'pl': [1, 2, 3, 4],
  'ple': [1, 2, 3, 4],
  'pp': [1, 2, 3, 4],
  'ppl': [1, 2, 3, 4],
  'pple': [1, 2, 3, 4],
  'ra': [3, 4],
  'rab': [3, 4],
  'raba': [3, 4],
  'rabap': [3, 4],
  'rabapp': [3, 4],
  'rabappl': [3, 4],
  'rabapple': [3, 4],
};
