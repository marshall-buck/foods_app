// ignore_for_file: comment_references

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';

import 'package:foods_app/widgets/widgets.dart';

/// A convenience widget that builds a [Scaffold] with a
/// [CustomScrollView] as its body.
///
/// The [CustomScrollView] will always include a [CustomSliverAppBar]
/// as its first sliver, and any number of additional slivers passed
/// in as the [slivers] argument.
///
/// The [CustomSliverAppBar] can be customized with a [title], or
/// [onClearSearch] and [textFieldKey]. If a [title] is provided,
/// the [CustomSliverAppBar] will display the title in the app bar.
/// Otherwise, a [FoodsAppSearchBar] will be displayed, along with
/// a clear button and a [FoodResultsCountBadge].
///
/// The [slivers] argument is a list of widgets that will be displayed
/// below the [CustomSliverAppBar].
///
/// The [scrollController] argument can be used to control the scrolling
/// of the [CustomScrollView].

class BasePage extends StatelessWidget {
  const BasePage({
    required this.slivers,
    super.key,
    this.scrollController,
  });
  final List<Widget> slivers;

  /// The scroll controller for the [CustomScrollView].
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FoodsAppThemeExtension.of(context).background,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          ...slivers,
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(IterableProperty<Widget>('slivers', slivers))
      ..add(
        DiagnosticsProperty<ScrollController?>(
          'scrollController',
          scrollController,
        ),
      );
    super.debugFillProperties(properties);
  }
}
