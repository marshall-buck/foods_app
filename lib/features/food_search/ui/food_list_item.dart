import 'package:flutter/material.dart';
import 'package:foods_app/common/text_styles.dart';
import 'package:foods_app/common/theme.dart';

import 'package:foods_app/features/food_search/food_search.dart';

class FoodListItem extends StatelessWidget {
  const FoodListItem({required super.key, required this.food});

  final FoodListItemModel food;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColorsExtension.of(context).outlineVariant,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FoodDescription(food: food),
                const QuickResults(
                  quickResultsList: ['100', '200', '300', '400'],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 48,
            child: Column(
              children: [
                Icon(
                  Icons.chevron_right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FoodDescription extends StatelessWidget {
  const FoodDescription({required this.food, super.key});

  final FoodListItemModel food;

  @override
  Widget build(BuildContext context) {
    return Text(
      food.description,
      style: AppTextStyle.m3BodyLarge
          .copyWith(color: AppColorsExtension.of(context).onBackground),
    );
  }
}

class QuickResults extends StatelessWidget {
  const QuickResults({required this.quickResultsList, super.key});
  final List<String> quickResultsList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          quickResultsList.toString(),
          style: AppTextStyle.m3BodyMedium
              .copyWith(color: AppColorsExtension.of(context).onSurfaceVariant),
        ),
      ],
    );
  }
}
