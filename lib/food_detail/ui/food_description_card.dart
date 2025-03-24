import 'package:flutter/material.dart';
import 'package:foods_app/adjust_amount/adjust_amount.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/domain/domain.dart';

class FoodDescriptionCard extends StatelessWidget {
  const FoodDescriptionCard({
    required this.food,
    required this.isEven,
    super.key,
  });

  final Food food;
  final bool isEven;

  @override
  Widget build(BuildContext context) {
    switch (isEven) {
      case true:
        return _LeftAlignedFoodItem(food: food);
      case false:
        return isEven ? _LeftAlignedFoodItem(food: food) : _RightAlignedFoodITem(food: food);
    }
  }
}

class _LeftAlignedFoodItem extends StatelessWidget {
  const _LeftAlignedFoodItem({
    required this.food,
  });
  final Food food;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(MagicSpacing.sp_4),
          child: AspectRatio(
            aspectRatio: 1,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onLongPress: () {
                Navigator.of(context).push(
                  CircularRangeSliderPopUp<void>(context: context, amount: food.defaultAmount, unit: food.unit),
                );
              },
              child: ClipOval(
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  child: Center(
                    child: AmountWidget(
                      amount: food.defaultAmount,
                      unit: food.unit,
                      textColor: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          // flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(
              right: MagicSpacing.sp_4,
            ),
            child: Text(
              food.name,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 4, //Limit the number of lines
              overflow: TextOverflow.ellipsis, //Handle overflow with ellipsis
            ),
          ),
        ),
      ],
    );
    //  },
    //
  }
}

class _RightAlignedFoodITem extends StatelessWidget {
  const _RightAlignedFoodITem({
    required this.food,
  });
  final Food food;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          // flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(
              right: MagicSpacing.sp_4,
            ),
            child: Text(
              food.name,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 4, //Limit the number of lines
              overflow: TextOverflow.ellipsis, //Handle overflow with ellipsis
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(MagicSpacing.sp_4),
          child: AspectRatio(
            aspectRatio: 1,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onLongPress: () {
                Navigator.of(context).push(
                  CircularRangeSliderPopUp<void>(context: context, amount: food.defaultAmount, unit: food.unit),
                );
              },
              child: ClipOval(
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  child: Center(
                    child: AmountWidget(
                      amount: food.defaultAmount,
                      unit: food.unit,
                      textColor: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
    //  },
    //
  }
}
