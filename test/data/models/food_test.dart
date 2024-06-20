import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/data/data.dart';
import 'package:usda_db_package/usda_db_package.dart';

void main() {
  group('FoodModel class tests', () {
    group('constructor tests', () {
      test('FoodModel makes new instance', () {
        const List<Nutrient> nutrient = [
          Nutrient(
            id: 1,
            name: 'Test Nutrient',
            amount: 10.0,
            unit: 'g',
          )
        ];

        const foodItem =
            FoodModel(id: 2, description: 'description', nutrients: nutrient);

        expect(foodItem, isA<FoodModel>());
        expect(foodItem.id, 2);
      });
      test('fromUsdaDB() -  converts from SrLegacyFoodModel to FoodModel', () {
        const SrLegacyFoodModel foodModel = SrLegacyFoodModel(
          id: 1,
          description: 'Test Food',
          nutrients: [
            SrLegacyNutrientModel(
                id: 1, name: 'Test Nutrient', amount: 10.0, unit: 'g')
          ],
        );

        final foodItem = FoodModel.fromUsdaDB(foodModel);

        expect(foodItem, isA<FoodModel>());
        expect(foodItem!.id, 1);
      });
    });
  });
}
