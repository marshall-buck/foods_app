import 'package:foods_app/services/models/food.dart';
import 'package:usda_db_package/usda_db_package.dart';

const protein =
    SrLegacyNutrientModel(id: 1003, amount: 20, unit: 'g', name: 'Protein');
const totalFat =
    SrLegacyNutrientModel(id: 1004, amount: 15, unit: 'g', name: 'Total Fat');
const totalCarbs = SrLegacyNutrientModel(
    id: 1005, amount: 30, unit: 'g', name: 'Total Carbohydrates');
const water =
    SrLegacyNutrientModel(id: 1051, amount: 500, unit: 'g', name: 'Water');
const totalSugars = SrLegacyNutrientModel(
    id: 2000, amount: 10, unit: 'g', name: 'Total Sugars');

const food1 = SrLegacyFoodModel(
    id: 1, description: 'Chicken Breast', nutrients: [protein]);
const food2 = SrLegacyFoodModel(
    id: 2, description: 'Apple', nutrients: [totalCarbs, water]);
const food3 =
    SrLegacyFoodModel(id: 3, description: 'Olive Oil', nutrients: [totalFat]);
const food4 = SrLegacyFoodModel(
    id: 4, description: 'Yogurt', nutrients: [protein, totalCarbs, water]);
const food5 = SrLegacyFoodModel(
    id: 5, description: 'Granola Bar', nutrients: [totalCarbs, totalSugars]);

final List<FoodModel> mockFoodsList = [
  FoodModel.fromUsdaDB(food1),
  FoodModel.fromUsdaDB(food2),
  FoodModel.fromUsdaDB(food3),
  FoodModel.fromUsdaDB(food4),
  FoodModel.fromUsdaDB(food5),
];
