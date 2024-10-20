import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';

import 'package:foods_app/features/features.dart';

class FoodsAppSearchBar extends StatelessWidget {
  const FoodsAppSearchBar({
    required this.hintText,
    required this.showBadge,
    this.controller,
    this.onTap,
    this.onClearSearch,
    this.onChanged,
    super.key,
  });
  final bool showBadge;
  final String hintText;
  final GestureTapCallback? onTap;
  final VoidCallback? onClearSearch;
  final TextEditingController? controller;

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: MagicNumbers.maxSearchBarWidth,
        child: SearchBar(
          hintText: hintText,
          trailing: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: onClearSearch,
                icon: const Icon(Icons.clear_outlined),
              ),
            ),
            if (showBadge) const FoodResultsCountBadge(),
          ],
          controller: controller,
          onChanged: onChanged,
          onTap: onTap,
        ),
      ),
    );
  }
}
