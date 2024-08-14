import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/food_search/food_search.dart';

class FoodListItem extends StatelessWidget {
  const FoodListItem({super.key, required this.foods, required this.index});

  final List<FoodListItemModel> foods;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
            bottom: BorderSide(
          width: 1,
          color: colors.outlineVariant,
        )),
      ),
      // color: colors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          FoodDescription(foods: foods, index: index),
          const QuickResults(
            quickResultText: '200 / 100 / 50 / 25',
          )
        ],
      ),
    );
  }
}

class QuickResults extends StatelessWidget {
  const QuickResults({super.key, required this.quickResultText});
  final String quickResultText;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          quickResultText,
          style: AppTextStyle.m3BodyMedium
              .copyWith(color: colors.onSurfaceVariant),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          style: const ButtonStyle(
              fixedSize: WidgetStatePropertyAll<Size>(Size(12, 12))),
          // alignment: AlignmentGeometry,
          iconSize: 12,
          onPressed: () {},
        ),
      ],
    );
  }
}

class FoodDescription extends StatelessWidget {
  const FoodDescription({super.key, required this.foods, required this.index});

  final List<FoodListItemModel> foods;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Text(
      foods[index].description,
      style: AppTextStyle.m3BodyLarge.copyWith(color: colors.onSurface),
    );
  }
}
