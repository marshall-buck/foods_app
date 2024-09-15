import 'package:flutter/material.dart';

import 'package:foods_app/widgets/widgets.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    required this.slivers,
    super.key,
    this.title,
    this.onClearSearch,
    this.textFieldKey,
    this.scrollController,
  });
  final List<Widget> slivers;
  final String? title;
  final GlobalKey<ReusableTextFieldState>? textFieldKey;
  final VoidCallback? onClearSearch;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 4),
            sliver: CustomSliverAppBar(
              titleString: title,
              onClearSearch: onClearSearch,
              textFieldKey: textFieldKey,
            ),
          ),
          ...slivers,
        ],
      ),
    );
  }
}
