import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/food_search/food_search.dart';

/// Displays a single food item in a list.
///
/// This widget displays the food's description and quick results.
/// It is typically used in a [ListView] or other scrollable list.
class FoodListItem extends StatelessWidget {
  /// Creates a [FoodListItem].
  ///
  /// The [food] argument is required and must not be null.
  const FoodListItem({required this.food, required super.key});

  /// The food item to display.
  final FoodListItemModel food;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FoodDescription(food: food),
                  QuickResults(
                    food: food,
                  ),
                ],
              ),
            ),
            const Column(
              children: [
                Icon(
                  Icons.chevron_right,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Displays the description of a food item.
///
/// This widget displays the food's description in a [Text] widget.
/// It is typically used as a child of a [FoodListItem].
class FoodDescription extends StatelessWidget {
  /// Creates a [FoodDescription].
  ///
  /// The [food] argument is required and must not be null.
  const FoodDescription({required this.food, super.key});

  /// The food item to display the description of.
  final FoodListItemModel food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(food.description, style: AppTextStyle.m3BodyLarge),
    );
  }
}

/// Displays a list of quick results for a food item.
///
/// This widget displays a list of quick results in a [Row] of [Text] widgets.
/// It is typically used as a child of a [FoodListItem].
class QuickResults extends StatelessWidget {
  /// Creates a [QuickResults].

  const QuickResults({required this.food, super.key});

  /// The list of quick results to display.
  final FoodListItemModel food;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FoodSearchBloc, FoodSearchState, List<String>>(
      selector: (state) {
        return state.quickSearchIds;
      },
      builder: (context, state) {
        return Row(
          children: food.quickResultsAmountsList.map((quickResult) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                quickResult,
                style: AppTextStyle.m3BodyMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

//  BlocBuilder<FoodSearchBloc, FoodSearchState>(
//                     buildWhen: (previous, current) => previous.quickSearchIds != current.quickSearchIds,
//                     builder: (context, state) {
//                       return QuickResults(
//                         quickResultsList: food.quickResultsAmountsList,
//                       );
//                     },
//                   ),


// BlocSelector<FoodSearchBloc, FoodSearchState, List<String>>(
//                     selector: (state) => state.quickSearchIds,
//                     builder: (context, state) {
//                       return QuickResults(
//                         quickResultsList: food.quickResultsAmountsList,
//                       );
//                     },
//                   ),