import 'package:flutter/material.dart';
import 'package:foods_app/widgets/widgets.dart';

class CircularRangeSliderPopUp<T> extends PopupRoute<T> {
  CircularRangeSliderPopUp({required this.context});
  late final BuildContext context;
  @override
  Color? get barrierColor =>
      Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7);

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
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
            child: const CircularRangeSlider(),
          ),
        ),
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
