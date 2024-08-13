// import 'package:flutter/material.dart';
// import 'package:foods_app/features/food_search/food_search.dart';

// // class FoodsList extends StatelessWidget {
// //

// class FoodsList extends StatelessWidget {
//   final List<FoodListItemModel> foods;

//   const FoodsList({Key? key, required this.foods}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SliverList(
//       delegate: SliverChildBuilderDelegate(
//         (BuildContext context, int index) {
//           return ListTile(
//             title: Text(foods[index].description),
//             subtitle: Text(foods[index].nutrients.toString()),
//           );
//         },
//         childCount: foods.length,
//       ),
//     );
//   }
// }
