/// The local data source is an external package.

// class LocalDB implements FoodsDBInterface {
//   UsdaDB? _localDBService;

//   Future<void> init() async {
//     if (_localDBService != null) {
//       dev.log(
//         '''_localDBService is already initiated,
//       if this is happening there is a bug that needs attention''',
//         name: '../lib/data/data_source',
//       );
//       return;
//     }

//     _localDBService = await UsdaDB.init();
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

