// import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:foods_app/widgets/widgets.dart';
import 'package:watch_it/watch_it.dart';

class FoodDescriptionCard extends StatelessWidget {
  const FoodDescriptionCard({
    required this.tileSize,
    required this.food,
    super.key,
  });

  final MagicTileDimension tileSize;
  final Food food;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(MagicSpacing.sp_4),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .colorScheme
                .shadow
                .withOpacity(MagicOpacity.op_50),
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
          AspectRatio(
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
              child: AmountWidget(
                id: food.id,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(MagicSpacing.sp_2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    food.description,
                    style: Theme.of(context).textTheme.bodySmall,
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
                          di.get<FoodDetailManager>().resetToOriginalAmounts();
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
