import 'package:foods_app/external_data/external_data.dart';
import 'package:foods_app/features/food_search/food_search.dart';
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

const List<String> foodNames = [
  "An apple.",
  "Bananas are a great source of potassium.",
  "Oranges are rich in vitamin C.",
  "Grapes can be eaten fresh or used to make wine.",
  "Watermelons are refreshing and hydrating, especially in the summer.",
  "Pineapples are tropical fruits that are sweet and tangy.",
  "Strawberries are delicious when dipped in chocolate.",
  "Blueberries are packed with antioxidants and are great for your health.",
  "Raspberries are small, red, and full of flavor.",
  "Blackberries are juicy and perfect for making jams.",
  "Mangoes are tropical fruits that are sweet and juicy.",
  "Papayas are rich in vitamins and enzymes that aid digestion.",
  "Peaches are soft, sweet, and perfect for pies.",
  "Plums are small, sweet, and have a pit in the center.",
  "Cherries are small, red, and often used in desserts.",
  "Kiwis are small, green, and have a tangy flavor.",
  "Lemons are sour and often used to add flavor to dishes.",
  "Limes are small, green, and used in many cocktails.",
  "Coconuts are tropical fruits that have a hard shell and sweet water inside.",
  "Avocados are creamy and often used in guacamole.",
  "Tomatoes are versatile and used in many dishes, including salads and sauces.",
  "Cucumbers are refreshing and often used in salads.",
  "Carrots are crunchy and good for your eyesight.",
  "Broccoli is a green vegetable that is rich in vitamins and minerals.",
  "Cauliflower can before rice or mashed potatoes.",
  "Spinach is a leafy green vegetable that is rich in iron.",
  "Lettuce is often used as a base for salads.",
  "Kale is at is rich in nutrients and antioxidants.",
  "Cabbage can be used in salads, soups, and stir-fries.",
  "Brussels sprouts are small, green, and often roasted or steamed.",
  "Potatoes are versatile and can be baked, mashed, or fried.",
  "Sweet potatoes are a healthier alternative to regular potatoes.",
  "Onions add flavor to many dishes and can be eaten raw or cooked.",
  "Garlic is often used to add flavor to dishes and has many health benefits.",
  "Ginger is a root that is often used in cooking and has medicinal properties.",
  "Beetroots are rich in nutrients and can be used in salads or juices.",
  "Radishes are crunchy and often used in salads.",
  "Turnips are root vegetables that can be roasted or mashed.",
  "Pumpkins are often used in pies and soups, especially during the fall season.",
  "Squash comes in many varieties and can be roasted, steamed, or used in soups.",
  "Zucchinis are versatile and can be used in many dishes, including stir-fries and salads.",
  "Eggplants are often used in Mediterranean and Asian cuisines.",
  "Bell peppers come in many colors and add a sweet flavor to dishes.",
  "Chili peppers add heat to dishes and come in many varieties.",
  "Corn can be eaten on the cob or used in many dishes, including soups and salads.",
  "Peas are small, green, and often used in soups and salads.",
  "Green beans are often steamed or sautéed and served as a side dish.",
  "Asparagus is a green vegetable that is often roasted or steamed.",
  "Artichokes are often steamed and served with a dipping sauce.",
  "Mushrooms come in maybe used in many dishes.",
  "Chicken is a versatile protein that can be grilled, baked, or fried.",
  "Beef can be used in many dishes, including steaks, burgers, and stews.",
  "Pork is often used in dishes such as bacon, ham, and sausages.",
  "Lamb is often used in MeMiddle Eastern cuisines.",
  "Turkey is often roasted and served during Thanksgiving.",
  "Duck is often used in Asian cuisines and has a rich flavor.",
  "Goose is often roasted and served during special occasions.",
  "Rabbit is often used in stews and has a mild flavor.",
  "Venison is a type of game meat that is often used in stews and roasts.",
  "Fish is a healthy protein that can be grilled, baked, or fried.",
  "Shrimp are often used in seafood dishes and can be grilled, boiled, or fried.",
  "Crabs are often steamed and served with butter or used in crab cakes.",
  "Lobsters are often steamed and served with butter or used in lobster rolls.",
  "Oysters are often  as oyster stew.",
  "Clams ",
  "Scallops are often seared and served as a main dish or used in seafood pasta.",
  "Squid is often used in.",
  "Octopus is often used in Mediterranean and Asian cuisines.",
  "Salmon is a healthy fish that is often grilled, baked, or smoked.",
  "Tuna is often used in sushi and can be grilled or canned.",
  "Bread is a staple food that comes in many varieties.",
  "Rice is a staple food that is often used as a side dish or in stir-fries.",
  "Pasta is a versatile food that comes in many shapes and can be used in many dishes.",
  "Noodles are often used in Asian cuisines and come in many varieties.",
  "Pizza is a popular dish that comes in many varieties and is often topped with cheese and tomato sauce.",
  "Burgers are often made with beef or chicken and served with a variety of toppings.",
  "Sandwiches are often made with bread and filled with a variety of ingredients.",
  "Tacos are often made with tortillas and filled with a variety of ingredients.",
  "Burritos are often made with tortillas and filled with a variety of ingredients.",
  "Sushi is a Japanese dish that often includes rice, fish, and vegetables.",
  "Cheese comes in many varieties and is often used in cooking and as a topping.",
  "Yogurt is a dairy product that is often eaten for breakfast or as a snack.",
  "Milk is a staple beverage that is often used in cooking and baking.",
  "Butter is often used in cooking and baking and adds flavor to dishes.",
  "Cream is often used in cooking and baking and adds richness to dishes.",
  "Ice cream is a popular dessert that comes in many flavors.",
  "Cake is often served as a dessert and comes in many varieties.",
  "Pie is often served as a dessert and comes in many varieties.",
  "Cookies are often served as a dessert and come in many varieties.",
  "Brownies are often served as a dessert and are rich and chocolatey.",
  "Chocolate is a popular treat that comes in many varieties.",
  "Candy is a popular treat that comes in many varieties.",
  "Popcorn is a popular snack that is often eaten at the movies.",
  "Chips are a popular snack that comes in many flavors.",
  "Pretzels are a popular snack that are often salty and crunchy.",
  "Nuts are a healthy snack that come in many varieties.",
  "Seeds are a healthy snack that come in many varieties.",
  "Granola is often eaten for breakfast or as a snack and is made with oats, nuts, and honey.",
  "Cereal is often eaten for breakfast and comes in many varieties.",
  "Oatmeal is often eaten for breakfast and is made with oats and water or milk."
];
