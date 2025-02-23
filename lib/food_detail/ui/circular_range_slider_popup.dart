import 'package:flutter/material.dart';
import 'package:foods_app/common/magic.dart';
import 'package:foods_app/domain/domain.dart';
import 'package:foods_app/food_detail/ui/ui.dart';

class CircularRangeSliderPopUp<T> extends PopupRoute<T> {
  CircularRangeSliderPopUp({required this.context, required this.id, required this.food});
  final BuildContext context;
  final int id;
  final Food food;
  @override
  Color? get barrierColor => Theme.of(context).colorScheme.primaryContainer.withValues(alpha: MagicOpacity.op_70);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Center(
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleLarge!,
        child: UnconstrainedBox(
          child: ClipOval(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: CircularRangeSlider(
                onPanUpdate: (direction, details) {
                  // di.get<FoodAmountManager>().changeUnits(direction, id);
                },
                // id: id,
                trackStroke: MagicNumbers.circularRangeSliderTrackStroke,
                handleRadius: MagicNumbers.circularRangeSliderHandleRadius,
                handleColor: Theme.of(context).colorScheme.primary,
                trackDiameter: MagicNumbers.circularRangeSliderTrackDiameter,
                trackColor: Theme.of(context).colorScheme.onSurface,
                child: AmountWidget(
                  food: food,
                  textColor: Theme.of(context).colorScheme.onSurface,
                  id: id,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
