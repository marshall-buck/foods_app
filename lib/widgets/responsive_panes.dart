import 'package:flutter/material.dart';

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

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          // Expanded or larger window size
          return Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: leftPane,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
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
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: leftPane,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: mainPane,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
