import 'package:flutter/material.dart';
import 'package:foods_app/common/theme.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';

/// A custom [SliverAppBar] that can display either a [titleString] or a
/// [ReusableTextField] for searching, in the title property
/// of the [SliverAppBar].
///
/// This widget enforces that either a [titleString] is provided, or both
/// [onClearSearch] and [textFieldKey] are provided. Providing a [titleString]
/// will display the title in the app bar. Otherwise, a [ReusableTextField]
/// will be displayed, along with a clear button and a  [FoodResultsCountBadge].
class CustomSliverAppBar extends StatelessWidget {
  /// Creates a [CustomSliverAppBar].
  ///
  /// Provide either a [titleString] or [textFieldKey] and [onClearSearch].
  const CustomSliverAppBar({
    this.onClearSearch,
    this.textFieldKey,
    this.titleString,
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

  /// The global key of the [ReusableTextField] used for searching.
  ///
  /// This is only used if no [titleString] is provided.
  final GlobalKey<ReusableTextFieldState>? textFieldKey;

  /// A callback that is called when the clear button is pressed.
  ///
  /// This is only used if no [titleString] is provided.
  final VoidCallback? onClearSearch;

  /// The title to display in the app bar.
  ///
  /// If this is provided, [onClearSearch] and [textFieldKey] must be null.
  final String? titleString;

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
              const FoodResultsCountBadge(),
            ]
          : null,
      floating: true,
      pinned: true,
      // expandedHeight: 300,
      stretch: true,
      backgroundColor: FoodsAppThemeExtension.of(context).background,
      title: titleString != null
          ? Text(titleString!)
          : ReusableTextField(
              key: textFieldKey,
            ),
    );
  }
}
