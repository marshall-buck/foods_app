import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/food_search/food_search.dart';

class FoodListItem extends StatelessWidget {
  const FoodListItem({required this.food, super.key});

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

class FoodDescription extends StatelessWidget {
  const FoodDescription({required this.food, super.key});

  final FoodListItemModel food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(food.description, style: AppTextStyle.m3BodyLarge),
    );
  }
}

class QuickResults extends StatelessWidget {
  const QuickResults({required this.food, super.key});

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
