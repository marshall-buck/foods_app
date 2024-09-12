import 'package:flutter/material.dart';
import 'package:foods_app/common/theme.dart';
import 'package:foods_app/features/food_search/food_search.dart';
import 'package:foods_app/widgets/reusable_text.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    required this.textFieldKey,
    required this.onClearSearch,
    super.key,
  });
  final GlobalKey<ReusableTextFieldState> textFieldKey;
  final VoidCallback onClearSearch;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: AppColorsExtension.of(context).surfaceTint,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: onClearSearch,
            icon: const Icon(Icons.clear_outlined),
          ),
        ),
        const FoodResultsCountBadge(),
      ],
      floating: true,
      title: NotificationListener<TextChangeNotification>(
        child: ReusableTextField(
          key: textFieldKey,
        ),
        onNotification: (notification) {
          // You'll need to pass this notification up to FoodSearchPage
          // You can use a callback or other state management techniques
          return true;
        },
      ),
      pinned: true,
    );
  }
}
