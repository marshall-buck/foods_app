// import 'package:flutter/material.dart';
// import 'package:foods_app/common/common.dart';
// import 'package:foods_app/domain/domain.dart';
// import 'package:foods_app/ui/ui.dart';

// class NutrientGrid extends StatelessWidget {
//   const NutrientGrid({
//     required this.tileSize,
//     required this.food,
//     super.key,
//   });

//   final MagicTileDimension tileSize;
//   final Food food;

//   @override
//   Widget build(BuildContext context) {
//     return SliverPadding(
//       padding: EdgeInsets.all(tileSize.spacing * 2),
//       sliver: SliverGrid.builder(
//         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: tileSize.dimension,
//           crossAxisSpacing: tileSize.spacing,
//           mainAxisSpacing: tileSize.spacing,
//         ),
//         itemCount: food.nutrientList.length,
//         itemBuilder: (BuildContext context, int index) {
//           final nutrientKey = Key('${food.id}:${food.nutrientList[index].id}');
//           return ClipOval(
//             child: NutrientListItem(key: nutrientKey, food: food, index: index),
//           );
//         },
//       ),
//     );
//   }
// }
