import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/food_detail/food_detail.dart';
import 'package:foods_app/food_search/food_search.dart';

//TODO: Maybe send the id into the FoodDetailPage, unless there is another need for the
// SearchResultsPage needing to know the ActiveFoodsState

/// {@template food_list_item}
/// A widget that displays a single food item in a list.
///
/// It includes a description and quick results for the food item.
/// When tapped, it navigates to the [FoodDetailPage] and triggers
/// a [FoodSearchListItemSelected] event in the [FoodSearchBloc].
/// {@endtemplate}
class FoodListItem extends StatelessWidget {
  /// {@macro food_list_item}
  const FoodListItem({required this.food, super.key});

  /// The model representing the food item.
  final FoodListItemModel food;

  /// Handles the tap event on the food item.
  ///
  /// Sends the selected food ID to the [FoodSearchBloc] and navigates
  /// to the [FoodDetailPage].
  void _handleOnTap(BuildContext context, int id) {
    if (context.mounted) {
      context.read<FoodSearchBloc>().add(FoodSearchListItemSelected(id));
      Navigator.push(
        context,
        MaterialPageRoute<FoodDetailPage>(
          builder: (context) => const FoodDetailPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleOnTap(context, food.id),
      child: Container(
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
                    _FoodDescription(food: food),
                    _QuickResults(
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
      ),
    );
  }
}

/// {@template food_description}
/// A widget that displays the description of a food item.
/// {@endtemplate}
class _FoodDescription extends StatelessWidget {
  /// {@macro food_description}
  const _FoodDescription({required this.food});

  /// The model representing the food item.
  final FoodListItemModel food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(food.description, style: AppTextStyle.m3BodyLarge),
    );
  }
}

/// {@template quick_results}
/// A widget that displays quick result amounts for a food item.
/// {@endtemplate}
class _QuickResults extends StatelessWidget {
  /// {@macro quick_results}
  const _QuickResults({required this.food});

  /// The model representing the food item.
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
