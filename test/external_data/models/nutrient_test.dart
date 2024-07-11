import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/external_data/external_services_B.dart';

import '../../setup/mock_data.dart';

void main() {
  group('Nutrient class model tests', () {});
  group('Nutrient.fromUsdaDB', () {
    test('creates nutrient from usda nutrient', () {
      final nutrient = Nutrient.fromUsdaDB(protein);
      expect(nutrient, isA<Nutrient>());

      expect(nutrient.id, 1003);
      expect(nutrient.name, 'Protein');
      expect(nutrient.amount, 20);
      expect(nutrient.unit, 'g');
    });
  });
}
