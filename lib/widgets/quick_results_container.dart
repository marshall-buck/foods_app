// import 'package:flutter/material.dart';
// import 'package:foods_app/common/common.dart';
// import 'package:foods_app/ui/core/quick_search_manager.dart';

// class QuickResultsContainer extends WatchingWidget {
//   const QuickResultsContainer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final quickResultsList = watchIt<QuickSearchManager>().quickSearchNames;
//     return Row(
//       children: quickResultsList.map((quickResult) {
//         return Padding(
//           padding: const EdgeInsets.only(right: 16),
//           child: Text(
//             quickResult,
//             style: AppTextStyle.m3LabelSmall.copyWith(
//               color: Theme.of(context).colorScheme.onSurfaceVariant,
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
