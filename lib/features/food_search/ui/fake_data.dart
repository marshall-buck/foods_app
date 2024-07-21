import 'package:foods_app/external_data/models/food.dart';
import 'package:foods_app/features/food_search/models/food_list_Item.dart';
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

const nutrients = [protein, totalFat, totalCarbs, water, totalSugars];
const mockQuickSearch = ['1003', '1004', '1005', '1051', '2000'];

const List<String> foodNames = [
  "Apple",
  "Banana",
  "Orange",
  "Grapes",
  "Watermelon",
  "Pineapple",
  "Strawberry",
  "Blueberry",
  "Raspberry",
  "Blackberry",
  "Mango",
  "Papaya",
  "Peach",
  "Plum",
  "Cherry",
  "Kiwi",
  "Lemon",
  "Lime",
  "Coconut",
  "Avocado",
  "Tomato",
  "Cucumber",
  "Carrot",
  "Broccoli",
  "Cauliflower",
  "Spinach",
  "Lettuce",
  "Kale",
  "Cabbage",
  "Brussels Sprouts",
  "Potato",
  "Sweet Potato",
  "Onion",
  "Garlic",
  "Ginger",
  "Beetroot",
  "Radish",
  "Turnip",
  "Pumpkin",
  "Squash",
  "Zucchini",
  "Eggplant",
  "Bell Pepper",
  "Chili Pepper",
  "Corn",
  "Peas",
  "Green Beans",
  "Asparagus",
  "Artichoke",
  "Mushroom",
  "Chicken",
  "Beef",
  "Pork",
  "Lamb",
  "Turkey",
  "Duck",
  "Goose",
  "Rabbit",
  "Venison",
  "Fish",
  "Shrimp",
  "Crab",
  "Lobster",
  "Oyster",
  "Clam",
  "Scallop",
  "Squid",
  "Octopus",
  "Salmon",
  "Tuna",
  "Bread",
  "Rice",
  "Pasta",
  "Noodles",
  "Pizza",
  "Burger",
  "Sandwich",
  "Taco",
  "Burrito",
  "Sushi",
  "Cheese",
  "Yogurt",
  "Milk",
  "Butter",
  "Cream",
  "Ice Cream",
  "Cake",
  "Pie",
  "Cookie",
  "Brownie",
  "Chocolate",
  "Candy",
  "Popcorn",
  "Chips",
  "Pretzel",
  "Nuts",
  "Seeds",
  "Granola",
  "Cereal",
  "Oatmeal"
];

Future<List<FoodListItemModel>> fakeFoodsListItems() async {
  final List<FoodModel?> mocks = [];
  for (int i = 0; i < foodNames.length; i++) {
    final food = foodNames[i];
    mocks.add(FoodModel.fromUsdaDB(
        SrLegacyFoodModel(id: i, description: food, nutrients: nutrients)));
  }

  return mocks
      .map((food) => FoodListItemModel.fromFoodModel(food!, mockQuickSearch))
      .toList();
}
