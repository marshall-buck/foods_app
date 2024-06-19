import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/data/data.dart';
import 'package:usda_db_package/usda_db_package.dart';

void main() {
  group('Nutrient class tests', () {
    group('Constructor tests', () {
      test('initiates new nutrient', () {
        const Nutrient nutrient = Nutrient(
          id: 1,
          name: 'Test Nutrient',
          amount: 10.0,
          unit: 'g',
        );

        expect(nutrient, isA<Nutrient>());
        expect(nutrient.id, 1);
        expect(nutrient.name, 'Test Nutrient');
        expect(nutrient.amount, 10.0);
        expect(nutrient.unit, 'g');
      });
      test('creates Nutrient from SrLegacyNutrientModel', () {
        const SrLegacyNutrientModel srNutrient = SrLegacyNutrientModel(
          id: 1,
          name: 'Test Nutrient',
          amount: 10.0,
          unit: 'g',
        );

        final Nutrient nutrient = Nutrient.fromUsdaDB(srNutrient);

        expect(nutrient, isA<Nutrient>());
        expect(nutrient.id, 1);
        expect(nutrient.name, 'Test Nutrient');
        expect(nutrient.amount, 10.0);
        expect(nutrient.unit, 'g');
      });
    });
  });
}
