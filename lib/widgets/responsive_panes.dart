import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    required this.leftPane,
    required this.mainPane,
    super.key,
  });
  final Widget leftPane;
  final Widget mainPane;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    // Get the background color
    final mainContainerColor = theme.colorScheme.surfaceContainerLowest;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MagicSpacing.sp_4),
        child: Container(
          decoration: BoxDecoration(
            color: mainContainerColor,
            borderRadius: BorderRadius.circular(MagicBorderRadius.br_10),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 1024) {
                // Expanded or larger window size
                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(
                          MagicSpacing.sp_2,
                          MagicSpacing.sp_2,
                          MagicSpacing.sp_2,
                          MagicSpacing.sp_1,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(MagicBorderRadius.br_10),
                        ),
                        child: leftPane,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(MagicBorderRadius.br_10),
                        ),
                        child: mainPane,
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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(MagicBorderRadius.br_10),
                          ),
                          child: leftPane,
                        ),
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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(MagicBorderRadius.br_10),
                          ),
                          child: mainPane,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
