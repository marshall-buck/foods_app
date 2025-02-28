import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/domain/domain.dart';
import 'package:foods_app/food_detail/ui/ui.dart';

class FoodDescriptionCard extends StatelessWidget {
  const FoodDescriptionCard({
    required this.food,
    super.key,
  });

  final Food food;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(MagicSpacing.sp_8),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withValues(alpha: MagicOpacity.op_50),
                blurRadius: MagicBlurRadius.blur_2,
                offset: const Offset(0, 1),
              ),
            ],
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
                          color: Theme.of(context).colorScheme.error,
                          child: Center(
                            child: AmountWidget(
                              food: food,
                              id: food.id,
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
                            food.description,
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
      },
    );
  }
}
