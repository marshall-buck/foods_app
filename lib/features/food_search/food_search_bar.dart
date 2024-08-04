import '../../common/theme.dart';
import 'managers/search_delegate.dart';
import 'package:flutter/material.dart';

class FoodSearchBar extends StatelessWidget {
  const FoodSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return SearchBar(
      hintText: 'Search For Foods',
      backgroundColor: WidgetStateProperty.all(colors.surfaceContainer),
      onTap: () => showSearch(
        context: context,
        delegate: FoodSearchDelegate(),
      ),
    );
  }
}