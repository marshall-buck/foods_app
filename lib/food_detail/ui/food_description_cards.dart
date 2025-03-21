// import 'package:flutter/material.dart';
// import 'package:foods_app/common/common.dart';
// import 'package:foods_app/domain/models/food.dart';
// import 'package:foods_app/food_detail/ui/ui.dart';

// class FoodDescriptionCards extends StatelessWidget {
//   const FoodDescriptionCards({required this.foods, super.key});
//   final List<Food?> foods;
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width;
//     final tileSize = MagicTileDimension.tileSize(windowSize: width);

//     return ListView.builder(
//       itemCount: foods.length,
//       itemBuilder: (context, index) {
//         final food = foods[index];
//         return SizedBox(height: tileSize.dimension, child: FoodDescriptionCard(food: food!));
//       },
//     );
//   }
// }
