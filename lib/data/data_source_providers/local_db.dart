// import 'package:foods_app/data/interfaces/foods_db_interface.dart';
// import 'package:foods_app/data/models/food.dart';
// import 'package:usda_db_package/usda_db_package.dart';

// /// The local data source is an external package.

// class LocalDB implements FoodsDBInterface {
//   static UsdaDB? _localDBService;
//   LocalDB._();
//   static Future<LocalDB> init() async {
//     final _instance = LocalDB._();
//     _localDBService = await UsdaDB.init();
//     return _instance;
//   }

//   static Future<void> dispose() async {
//     await _localDBService?.dispose();
//     _localDBService = null;
//   }

//   bool get isDataLoaded =>
//       _localDBService != null ? _localDBService!.isDataLoaded : false;

//   @override
//   Future<FoodModel?> queryFood({required id}) async {
//     final SrLegacyFoodModel? food = await _localDBService?.queryFood(id: id);
//     return FoodModel.fromUsdaDB(food);
//   }

//   @override
//   Future<List<FoodModel?>> queryFoods({required String searchTerm}) async {
//     final List<SrLegacyFoodModel?> foods =
//         await _localDBService!.queryFoods(searchString: searchTerm);

//     return foods.isEmpty ? [] : foods.map(FoodModel.fromUsdaDB).toList();
//   }
// }
