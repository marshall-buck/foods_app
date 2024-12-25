import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/data/services.dart';
import 'package:usda_db_package/usda_db_package.dart';

void main() {
  group('FoodDTO class tests', () {
    group(' FoodDTO.fromUsdaDB', () {
      test('converts to FoodDTO', () {
        final food = FoodDTO.fromUsdaDB(
          const SrLegacyFoodModel(
            id: 167516,
            description: 'Waffles, buttermilk, frozen, ready-to-heat',
            nutrients: {
              1258: 10.0,
              1003: 6.58,
              1079: 2.2,
              1008: 273,
              2000: 4.3,
              1004: 9.22,
              1005: 41.0,
            },
          ),
        );

        expect(food, isA<FoodDTO>());
        expect(food.id, 167516);
        expect(food.description, 'Waffles, buttermilk, frozen, ready-to-heat');
        expect(food.nutrients, isA<Map<int, double>>());
      });
    });
    group('allNutrientDTOs getter', () {
      test('gets all nutrients', () {
        final food = FoodDTO.fromUsdaDB(
          const SrLegacyFoodModel(
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

        final allNutrientDTOs = food.allNutrientDTOs;
        expect(allNutrientDTOs, isA<Map<int, NutrientDTO>>());
        expect(allNutrientDTOs.length, 7);
        expect(allNutrientDTOs[1258], isA<NutrientDTO>());
        expect(allNutrientDTOs[1003]!.id, 1003);
        expect(allNutrientDTOs[1003]!.name, 'Protein');
        expect(allNutrientDTOs[1003]!.amount, 6.58);
        expect(allNutrientDTOs[1003]!.unit, 'g');
      });
    });
  });
}
