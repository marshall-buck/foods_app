import 'package:flutter/material.dart';
import 'package:foods_app/common/text_styles.dart';
import 'package:foods_app/common/theme.dart';

import 'package:foods_app/features/food_search/food_search.dart';

// TODO: refactor layout of item
class FoodListItem extends StatelessWidget {
  const FoodListItem({required super.key, required this.food});

  final FoodListItemModel food;

  @override
  Widget build(BuildContext context) {
    // final colors = AppColorsExtension.of(context);

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          // color: colors.surface,
          border: Border(
            bottom: BorderSide(
              color: AppColorsExtension.of(context).outlineVariant,
            ),
          ),
        ),
        // color: colors.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            FoodDescription(food: food),
            const QuickResults(
              quickResultText: '200 / 100 / 50 / 25',
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
    // final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Text(
      food.description,
      style: AppTextStyle.m3BodyLarge
          .copyWith(color: AppColorsExtension.of(context).onBackground),
    );
  }
}

class QuickResults extends StatelessWidget {
  const QuickResults({required this.quickResultText, super.key});
  final String quickResultText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          quickResultText,
          style: AppTextStyle.m3BodyMedium
              .copyWith(color: AppColorsExtension.of(context).onSurfaceVariant),
        ),
        const Icon(
          Icons.chevron_right,
        ),
      ],
    );
  }
}
