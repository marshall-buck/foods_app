import 'package:flutter/material.dart';

import 'package:foods_app/common/text_styles.dart';
import 'package:foods_app/common/theme.dart';

import 'package:foods_app/features/food_search/models/food_list_item.dart';

class FoodListItem extends StatelessWidget {
  const FoodListItem({super.key, required this.foods, required this.index});

  final List<FoodListItemModel> foods;
  final int index;

  // void _onPressed() {}
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final description =
        AppTextStyle.m3BodyLarge.copyWith(color: colors.onSurface);
    final quickLook =
        AppTextStyle.m3BodyMedium.copyWith(color: colors.onSurfaceVariant);
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
          Text(
            foods[index].description,
            style: description,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '200 / 100 / 50 / 25',
                style: quickLook,
              ),
              const Icon(Icons.chevron_right)
            ],
          ),
        ],
      ),
    );
  }
}
