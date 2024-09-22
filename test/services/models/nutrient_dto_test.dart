import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/services/services.dart';
import 'package:usda_db_package/usda_db_package.dart';

void main() {
  group('NutrientDTO class tests', () {
    group('named constructor', () {
      test('initializes correctly', () {
        const nutrient =
            NutrientDTO(id: 1004, amount: .55, name: 'Protein', unit: 'g');

        expect(nutrient, isA<NutrientDTO>());
        expect(nutrient.id, 1004);
        expect(nutrient.amount, .55);
        expect(nutrient.name, 'Protein');
        expect(nutrient.unit, 'g');
      });
    });
    group('NutrientDTO.fromUsdaDB', () {
      test("factory init's correctly", () {
        final nutrient = NutrientDTO.fromUsdaDB(
          const SrLegacyNutrientModel(
            id: 1004,
            amount: .55,
            name: 'Protein',
            unit: 'g',
          ),
        );

        expect(nutrient, isA<NutrientDTO>());
        expect(nutrient.id, 1004);
        expect(nutrient.amount, .55);
        expect(nutrient.name, 'Protein');
        expect(nutrient.unit, 'g');
      });
    });
    group('NutrientDTO.fromId', () {
      test('initializes correctly form an Map entry', () {
        const entry = MapEntry(1003, .55 as num);
        final nutrient = NutrientDTO.fromMapEntry(entry);
        expect(nutrient.name, 'Protein');
        expect(nutrient.amount, .55);
        expect(nutrient.unit, 'g');
        expect(nutrient.id, 1003);
      });
    });
  });
}
