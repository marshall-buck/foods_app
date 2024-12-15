import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/ui/ui.dart';
import 'package:watch_it/watch_it.dart';

class FoodComparisonPage extends StatefulWidget {
  const FoodComparisonPage({super.key});

  @override
  State<FoodComparisonPage> createState() => _FoodComparisonPageState();
}

class _FoodComparisonPageState extends State<FoodComparisonPage> {
  final _searchBarController = TextEditingController();
  final _scrollController = ScrollController();

  bool _showQuickResults = false;

  Future<void> _onChanged() async {
    await di.get<FoodSearchManager>().queryFoods(_searchBarController.text);
    setState(() {});
  }

  void _onClearSearch() {
    _searchBarController.clear();

    di.get<FoodSearchManager>().clearSearch();
    _showQuickResults = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isPort = size.width < size.height;
    final foodManager = watchIt<FoodSearchManager>();

    dev.log('$isPort', name: '_isPort');
    return Material(
      child: SafeArea(
        child: Column(
          spacing: MagicSpacing.sp_2,
          children: [
            SearchBar(
              controller: _searchBarController,
              constraints: Theme.of(context).searchBarTheme.constraints,
              hintText: MagicStrings.searchPageHintText,
              trailing: [
                if (foodManager.hasResults)
                  const FoodResultsCountBadge()
                else
                  const Spacer(),
                IconButton(
                  onPressed: _onClearSearch,
                  icon: const Icon(Icons.clear_outlined),
                ),
              ],
              onChanged: (string) => _onChanged(),
            ),
          ],
        ),
      ),
    );
  }
}

//  return isPort == false
//         ? const Row(
//             children: [
//               Expanded(child: Placeholder()),
//               Expanded(child: Placeholder()),
//             ],
//           )
//         : const Column(
//             children: [
//               Expanded(child: Placeholder()),
//               Expanded(child: Placeholder()),
//               Expanded(child: Placeholder()),
//             ],
//           );

//  delegate: _MySliverHeaderDelegate(
//                     child: Padding(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: tileSize.spacing),
//                       child: FoodDescriptionCard(
//                         tileSize: tileSize,
//                         food: food!,
//                       ),
//                     ),
//                     maxHeight: tileSize.dimension,
//                     minHeight: 100,
//                   ),
//                 ),
