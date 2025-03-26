import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

class ResponsivePanes extends StatelessWidget {
  const ResponsivePanes({
    required this.foodsPane,
    required this.nutrientsPane,
    super.key,
  });
  final Widget foodsPane;
  final Widget nutrientsPane;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 1024) {
            // Expanded or larger window size
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    MagicSpacing.sp_2,
                    MagicSpacing.sp_2,
                    MagicSpacing.sp_2,
                    MagicSpacing.sp_1,
                  ),
                  child: foodsPane,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MagicBorderRadius.br_10),
                    ),
                    child: nutrientsPane,
                  ),
                ),
              ],
            );
          } else {
            // Compact or medium window size
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
