import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/external_data/external_services_B.dart';

import '../../setup/mock_data.dart';

void main() {
  group('Food class model tests', () {});
  group('Food.fromUsdaDB', () {
    test('creates food from usda food', () {
      final food = FoodModel.fromUsdaDB(food1);
      expect(food, isA<FoodModel>());

      expect(food.id, 1);
      expect(food.description, 'Chicken Breast');
      expect(food.nutrients.length, 1);
      expect(food.nutrients[0], isA<Nutrient>());
    });
  });
}
