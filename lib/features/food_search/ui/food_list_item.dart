import 'package:flutter/material.dart';
import 'package:foods_app/common/zcommon.dart';
import 'package:foods_app/features/food_search/models/food_list_item.dart';

class FoodListItem extends StatelessWidget {
  const FoodListItem({super.key, required this.foods, required this.index});

  final List<FoodListItemModel> foods;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      constraints: const BoxConstraints(maxHeight: 128),
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
          const QuickResults(),
        ],
      ),
    );
  }
}

class QuickResults extends StatelessWidget {
  const QuickResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final quickLookStyle =
        AppTextStyle.m3BodyMedium.copyWith(color: colors.onSurfaceVariant);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '200 / 100 / 50 / 25',
          style: quickLookStyle,
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
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
    final descriptionStyle =
        AppTextStyle.m3BodyLarge.copyWith(color: colors.onSurface);
    return Text(
      foods[index].description,
      style: descriptionStyle,
    );
  }
}
