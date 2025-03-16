import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/food_detail/ui/food_detail_page.dart';
import 'package:foods_app/food_search/food_search.dart';

//TODO: Maybe send hte id into the FoodDetialPage, unless there is another need for the
// SearchREsultsPage neding to know the ActiveFoodsState
class FoodListItem extends StatelessWidget {
  const FoodListItem({required this.food, super.key});

  final FoodListItemModel food;

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

class _FoodDescription extends StatelessWidget {
  const _FoodDescription({required this.food});

  final FoodListItemModel food;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(food.description, style: AppTextStyle.m3BodyLarge),
    );
  }
}

class _QuickResults extends StatelessWidget {
  const _QuickResults({required this.food});

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
