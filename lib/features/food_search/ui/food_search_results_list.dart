import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/food_search/food_search.dart';

class FoodSearchResultsList extends StatelessWidget {
  const FoodSearchResultsList({
    super.key,
    required this.foodManager,
  });

  final FoodSearchManager foodManager;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return FutureBuilder(
      future: foodManager.getMockData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            color: colors.surface,
            child: FoodsList(foods: snapshot.data),
          );
        } else if (snapshot.hasError) {
          print('Snapshot error: ${snapshot.error}');
          print('Snapshot stacktrace: ${snapshot.stackTrace}');
          return Column(
            children: [
              const Icon(
                Icons.error_outline,
                size: 24,
                color: Colors.blueAccent,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ],
          );
        } else {
          return const Column(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator.adaptive(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ],
          );
        }
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:foods_app/common/common.dart';
// import 'package:foods_app/features/food_search/food_search.dart';
//
// class FoodSearchResultsList extends StatelessWidget {
//   const FoodSearchResultsList({
//     super.key,
//     required this.foodManager,
//   });
//
//   final FoodSearchManager foodManager;
//
//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).extension<AppColorsExtension>()!;
//     return ValueListenableBuilder<List<FoodListItemModel>?>(
//       valueListenable: foodManager.currentResults,
//       builder: (context, foods, _) {
//         if (foods != null) {
//           return Container(
//             padding: const EdgeInsets.only(left: 16, right: 16),
//             color: colors.surface,
//             child: FoodsList(foods: foods),
//           );
//         } else {
//           return const Column(
//             children: [
//               SizedBox(
//                 width: 60,
//                 height: 60,
//                 child: CircularProgressIndicator.adaptive(),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 16),
//                 child: Text('Awaiting result...'),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }
// }
