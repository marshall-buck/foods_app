import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    this.titleString,
    this.titleWidget,
    this.flexSpaceWidget,
    super.key,
  });
  final Widget? titleWidget;
  final Widget? flexSpaceWidget;
  final String? titleString;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: kToolbarHeight + 32,
      automaticallyImplyLeading: false,
      floating: true,
      title: titleString != null ? Text(titleString!) : titleWidget,
      flexibleSpace: titleString == null ? flexSpaceWidget : null,
    );
  }
}
