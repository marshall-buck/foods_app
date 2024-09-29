import 'package:flutter/material.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';

/// A custom [SliverAppBar] that can display either a [titleString] or a
/// [FoodsAppSearchBar] for searching, in the title property
/// of the [SliverAppBar].
///
/// This widget enforces that either a [titleString] is provided, or both
/// [onClearSearch] and [textFieldKey] are provided.
///
/// Providing a [titleString] will display the title in the app bar.
/// Otherwise, a [FoodsAppSearchBar] will be displayed, along with a
/// clear button and a  [FoodResultsCountBadge].
class CustomSliverAppBar extends StatelessWidget {
  /// Creates a [CustomSliverAppBar].
  ///
  /// Provide either a [titleString] or [textFieldKey] and [onClearSearch].
  const CustomSliverAppBar({
    this.onClearSearch,
    this.textFieldKey,
    this.titleString,
    this.showBadge = true,
    this.hintText,
    super.key,
  }) : assert(
          (titleString != null &&
                  onClearSearch == null &&
                  textFieldKey == null) ||
              (titleString == null &&
                  onClearSearch != null &&
                  textFieldKey != null),
          '''
                Either titleString must be provided, or both onClearSearch and
                  textFieldKey must be provided.
          ''',
        );

  /// The global key of the [FoodsAppSearchBar] used for searching.
  ///
  /// This is only used if no [titleString] is provided.
  final GlobalKey<FoodsAppSearchBarState>? textFieldKey;

  /// A callback that is called when the clear button is pressed.
  ///
  /// This is only used if no [titleString] is provided.
  final VoidCallback? onClearSearch;

  /// The title to display in the app bar.
  ///
  /// If this is provided, [onClearSearch] and [textFieldKey] must be null.
  final String? titleString;

  final bool showBadge;

  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: FoodsAppThemeExtension.of(context).surfaceTint,
      actions: titleString == null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: onClearSearch,
                  icon: const Icon(Icons.clear_outlined),
                ),
              ),
              if (showBadge) const FoodResultsCountBadge(),
              // else
              //   const SizedBox.shrink(),
            ]
          : null,
      automaticallyImplyLeading: titleString == null,
      floating: true,
      pinned: true,
      stretch: true,
      backgroundColor: FoodsAppThemeExtension.of(context).background,
      title: titleString != null
          ? Text(titleString!)
          : FoodsAppSearchBar(
              key: textFieldKey,
              hintText: hintText ?? AppStrings.searchPageHintText,
            ),
    );
  }
}
