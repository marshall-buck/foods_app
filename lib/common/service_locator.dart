// import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
// import 'package:foods_app/common/common.dart';
// import 'package:foods_app/data/data.dart';
// import 'package:foods_app/domain/domain.dart';
// import 'package:foods_app/ui/core/quick_search_manager.dart';
// import 'package:foods_app/ui/ui.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:usda_db_package/usda_db_package.dart';

// /// Registers all get_it dependencies.
// void registerDependencies() {
//   di
//     ..registerSingleton<FoodSearchManager>(
//       FoodSearchManager(),
//     ) //FoodSearchVM

//     ..registerSingleton<FoodAmountManager>(
//       FoodAmountManager(),
//     ) //FoodDetailVM

//     ..registerSingleton<AppHistoryState>(
//       AppHistoryState(),
//     ) //AppHistoryState

//     ..registerSingleton<FoodCompareManager>(
//       FoodCompareManager(),
//     ) //FoodCompareManager

//     // ignore: strict_raw_type
//     ..registerSingletonAsync<PreferencesService>(
//       () async {
//         final shared = SharedPreferencesAsync();
//         final settings = SharedUserPrefsServiceImp(shared);
//         await settings.init();
//         return settings;
//       },
//       instanceName: LocatorInstanceNames.sharedPrefsService,
//     ) //PreferencesService

//     // ..registerSingletonAsync<FoodsDB>(
//     //   () async {
//     //     // initializes auto_hyphenating_text package,
//     //     await initHyphenation();
//     //     final usdaDB = UsdaDB();
//     //     await usdaDB.init();
//     //     assert(usdaDB.isDataLoaded == true, 'usdaDB is not loaded');
//     //     return FoodsDBRepo(usdaDB);
//     //   },
//     //   instanceName: LocatorInstanceNames.foodsDBService,
//     //   dispose: (x) async => x.dispose(),
//     // ) //FoodsDB
//     //
//     ..registerSingletonAsync<QuickSearchManager>(
//       () async {
//         final manager = QuickSearchManager();
//         await manager.init();
//         return manager;
//       },
//       dependsOn: [
//         InitDependency(
//           PreferencesService,
//           instanceName: LocatorInstanceNames.sharedPrefsService,
//         ),
//       ],
//     ); //QuickSearchManager
// }
