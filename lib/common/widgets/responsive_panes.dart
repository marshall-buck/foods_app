import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

/// {@template responsive_panes}
/// A widget that adapts its layout based on the available screen width.
///
/// Displays two panes (`foodsPane` and `nutrientsPane`) side-by-side
/// when the screen width is greater than or equal to a predefined breakpoint.
/// Otherwise, it displays the panes stacked vertically.
///
/// This widget ensures proper padding and spacing for both layouts.
/// {@endtemplate}
class ResponsivePanes extends StatelessWidget {
  /// {@macro responsive_panes}
  const ResponsivePanes({
    required this.foodsPane,
    required this.nutrientsPane,
    super.key,
  });

  /// The widget to display in the first pane (e.g., a list of foods).
  final Widget foodsPane;

  /// The widget to display in the second pane (e.g., a list of nutrients).
  final Widget nutrientsPane;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= MagicBreakPoints.md) {
            return Row(
              children: [
                Expanded(
                  //TODO:Padding need to be adjusted.
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      MagicSpacing.sp_2,
                      MagicSpacing.sp_2,
                      MagicSpacing.sp_2,
                      MagicSpacing.sp_1,
                    ),
                    child: foodsPane,
                  ),
                ),
                Expanded(
                  //TODO:Padding need to be adjusted.
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      MagicSpacing.sp_2,
                      MagicSpacing.sp_1,
                      MagicSpacing.sp_2,
                      MagicSpacing.sp_2,
                    ),
                    child: nutrientsPane,
                  ),
                ),
              ],
            );
          } else {
            // smaller than md.
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      MagicSpacing.sp_2,
                      MagicSpacing.sp_2,
                      MagicSpacing.sp_2,
                      MagicSpacing.sp_1,
                    ),
                    child: foodsPane,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      MagicSpacing.sp_2,
                      MagicSpacing.sp_1,
                      MagicSpacing.sp_2,
                      MagicSpacing.sp_2,
                    ),
                    child: nutrientsPane,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
