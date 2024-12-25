import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/data/services.dart';
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
        const entry = MapEntry(1003, 10.0);
        final nutrient = NutrientDTO.fromMapEntry(entry);
        expect(nutrient.name, 'Protein');
        expect(nutrient.amount, 10.0);
        expect(nutrient.amount, isA<double>());
        expect(nutrient.unit, 'g');
        expect(nutrient.id, 1003);
      });
    });
  });
}
