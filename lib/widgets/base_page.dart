import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

import 'package:foods_app/widgets/widgets.dart';

/// A convenience widget that builds a [Scaffold] with a

class BasePage extends StatelessWidget {
  const BasePage({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<Widget>('widget', child));

    super.debugFillProperties(properties);
  }
}
