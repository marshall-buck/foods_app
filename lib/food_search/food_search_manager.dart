// import 'dart:async';
// import 'dart:developer' as dev;
// import 'package:flutter/widgets.dart';
// import 'package:foods_app/common/common.dart';
// import 'package:foods_app/domain/domain.dart';

// import 'package:foods_app/data/data.dart';

// /// Manages the searching of foods by a search term.
// class FoodSearchManager extends ChangeNotifier {
//   List<FoodListItemModel?> _currentResults = [];

//   List<FoodListItemModel?> get currentResults => _currentResults;

//   int get resultsCount => _currentResults.length;

//   bool get hasResults => _currentResults.isNotEmpty;

//   Future<void> queryFood(int id) async {
//     Food? food;
//     try {
//       final foodsDB =
//           di.get<FoodsApi>(instanceName: LocatorInstanceNames.foodsDBService);

//       final foodDTO = await foodsDB.queryFood(id: id);
//       food = Food.fromFoodDTO(foodDTO!);

//       di.get<AppHistoryState>().addFoodToHistory(food);
//     } catch (e) {
//       dev.log(
//         'queryFood throws',
//         name: 'FoodSearchManager - queryFood',
//         time: DateTime.now(),
//         error: e,
//       );
//     }
//   }

//   Future<void> queryFoods(String string) async {
//     try {
//       final db = await di.getAsync<FoodsApi>(
//         instanceName: LocatorInstanceNames.foodsDBService,
//       );

//       final foods = await db.queryFoods(searchTerm: string);

//       if (foods.isNotEmpty) {
//         final newItems = <FoodListItemModel?>[];
//         for (final food in foods) {
//           newItems.add(await FoodListItemModel.fromFoodDTO(food!));
//         }
//         _currentResults = newItems;
//       } else {
//         _currentResults = [];
//       }
//     } catch (e) {
//       dev.log(
//         'queryFoods throws',
//         time: DateTime.now(),
//         name: 'FoodSearchManager - queryFoods()',
//         error: e,
//       );
//       _currentResults = [];
//     } finally {
//       dev.log(
//         'FoodSearchResults.length: ${_currentResults.length}',
//         time: DateTime.now(),
//         name: 'FoodSearchManager.queryFoods()',
//       );
//       notifyListeners();
//     }
//   }

//   void clearSearch() {
//     _currentResults = [];
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     super.dispose();

//     notifyListeners();
//   }
// }
