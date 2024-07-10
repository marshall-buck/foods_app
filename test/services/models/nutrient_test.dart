import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/services/services_B.dart';

import '../../mock_data.dart';

void main() {
  group('Nutrient class model tests', () {});
  group('Nutrient.fromUsdaDB', () {
    test('test_create_nutrient_from_valid_usda_db', () {
      final nutrient = Nutrient.fromUsdaDB(protein);
      expect(nutrient, isA<Nutrient>());

      expect(nutrient.id, 1003);
      expect(nutrient.name, 'Protein');
      expect(nutrient.amount, 20);
      expect(nutrient.unit, 'g');
    });
  });
}
