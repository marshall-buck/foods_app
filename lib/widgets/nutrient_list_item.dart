// import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
// import 'package:flutter/material.dart';
// import 'package:foods_app/common/common.dart';
// import 'package:foods_app/domain/domain.dart';
// import 'package:foods_app/ui/ui.dart';

// class NutrientListItem extends StatelessWidget {
//   const NutrientListItem({
//     required this.food,
//     required this.index,
//     super.key,
//   });

//   final Food food;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         // borderRadius: BorderRadius.circular(16),
//         color: Theme.of(context).colorScheme.surfaceContainer,
//       ),
//       child: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onLongPress: () {
//           Navigator.of(context).push(
//             CircularRangeSliderPopUp<void>(
//               context: context,
//               id: food.nutrientList[index].id,
//             ),
//           );
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: MagicSpacing.sp_4,
//                     ),
//                     child: AutoHyphenatingText(
//                       textAlign: TextAlign.center,
//                       food.nutrientList[index].name,
//                       style: Theme.of(context).textTheme.labelSmall,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             AmountWidget(
//               id: food.nutrientList[index].id,
//               textColor: Theme.of(context).colorScheme.onSurface,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
