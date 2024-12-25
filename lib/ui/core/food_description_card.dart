// import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/domain/domain.dart';

import 'package:foods_app/ui/ui.dart';
import 'package:watch_it/watch_it.dart';

class FoodDescriptionCard extends WatchingWidget {
  const FoodDescriptionCard({
    required this.tileSize,
    required this.food,
    super.key,
  });

  final MagicTileDimension tileSize;
  final Food food;

  @override
  Widget build(BuildContext context) {
    callOnce(
      (_) => di.get<FoodAmountManager>().initAmountStrings(food),
      dispose: () => di.get<FoodAmountManager>().clearAmounts(),
    );
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(MagicSpacing.sp_8),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .colorScheme
                .shadow
                .withValues(alpha: MagicOpacity.op_50),
            blurRadius: MagicBlurRadius.blur_2,
            offset: const Offset(
              0,
              1,
            ),
          ),
        ],
      ),
      height: tileSize.dimension,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(MagicSpacing.sp_4),
            child: AspectRatio(
              aspectRatio: 1,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onLongPress: () {
                  Navigator.of(context).push(
                    CircularRangeSliderPopUp<void>(
                      context: context,
                      id: food.id,
                    ),
                  );
                },
                child: ClipOval(
                  child: ColoredBox(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    child: Center(
                      child: AmountWidget(
                        id: food.id,
                        textColor: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: MagicSpacing.sp_4,
                right: MagicSpacing.sp_4,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      food.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.save_as),
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.edit),
                      // ),
                      IconButton(
                        onPressed: () {
                          di.get<FoodAmountManager>().resetToOriginalAmounts();
                        },
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
