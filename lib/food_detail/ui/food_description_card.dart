import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/domain/domain.dart';
import 'package:foods_app/edit_amount/edit_amount.dart';
import 'package:foods_app/food_detail/ui/ui.dart';

class FoodDescriptionCard extends StatelessWidget {
  const FoodDescriptionCard({
    required this.food,
    super.key,
  });

  final Food food;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(MagicBorderRadius.br_10),
      ),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(MagicSpacing.sp_4),
              child: AspectRatio(
                aspectRatio: 1,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onLongPress: () {
                    Navigator.of(context).push(
                      CircularRangeSliderPopUp<void>(context: context, id: food.id, food: food),
                    );
                  },
                  child: ClipOval(
                    child: ColoredBox(
                      color: Theme.of(context).colorScheme.surfaceBright,
                      child: Center(
                        child: AmountWidget(
                          amount: 0.9,
                          unit: 'g',
                          textColor: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                top: MagicSpacing.sp_4,
                right: MagicSpacing.sp_4,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        food.name,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 4, //Limit the number of lines
                        overflow: TextOverflow.ellipsis, //Handle overflow with ellipsis
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.save_as),
                            constraints: const BoxConstraints(), //Remove icon button constraints
                            padding: EdgeInsets.zero, //Remove icon button padding
                          ),
                        ),
                        Flexible(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        Flexible(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.refresh),
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    //  },
    //
  }
}
