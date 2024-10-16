import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';
import 'package:watch_it/watch_it.dart';

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
class CustomSliverAppBar extends StatefulWidget {
  /// Creates a [CustomSliverAppBar].
  ///
  /// Provide either a [titleString] or [textFieldKey] and [onClearSearch].
  const CustomSliverAppBar({
    this.onClearSearch,
    this.textFieldKey,
    this.titleString,
    this.showBadge = true,
    this.hintText,
    // this.scrollController,
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
  // final ScrollController? scrollController;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<GlobalKey<FoodsAppSearchBarState>?>(
          'textFieldKey',
          textFieldKey,
        ),
      )
      ..add(
        ObjectFlagProperty<VoidCallback>.has('onClearSearch', onClearSearch),
      )
      ..add(StringProperty('titleString', titleString))
      ..add(
        FlagProperty(
          'showBadge',
          value: showBadge,
          ifTrue: 'showing badge',
          ifFalse: 'not showing badge',
        ),
      )
      ..add(StringProperty('hintText', hintText));
  }

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  @override
  void initState() {
    // widget.scrollController?.addListener(_onScrollListener);

    super.initState();
  }

  // void _onScrollListener() {
  //   if (ScrollDirection.forward ==
  //       widget.scrollController?.position.userScrollDirection) {
  //     setState(() {
  //       _opacity = 1;
  //     });
  //   } else {
  //     setState(() {
  //       _opacity = 0;
  //     });
  //   }

  // }

  @override
  void dispose() {
    widget.textFieldKey?.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: FoodsAppThemeExtension.of(context).surfaceTint,
      actions: widget.titleString == null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: widget.onClearSearch,
                  icon: const Icon(Icons.clear_outlined),
                ),
              ),
              if (widget.showBadge) const FoodResultsCountBadge(),
            ]
          : null,
      expandedHeight: kToolbarHeight + 32,
      automaticallyImplyLeading: widget.titleString == null,
      floating: true,
      snap: true,
      backgroundColor: FoodsAppThemeExtension.of(context).background,
      title: widget.titleString != null
          ? Text(widget.titleString!)
          : Hero(
              tag: MagicStrings.searchBarHeroTag,
              child: FoodsAppSearchBar(
                key: widget.textFieldKey,
                hintText: widget.hintText ?? MagicStrings.searchPageHintText,
              ),
            ),
      flexibleSpace:
          widget.titleString == null ? const _QuickSearchHeader() : null,
    );
  }
}

class _QuickSearchHeader extends WatchingWidget {
  const _QuickSearchHeader();

  @override
  Widget build(BuildContext context) {
    final namesList = watchValue((QuickSearchManager m) => m.quickSearchNames);
    final opacity = watchValue((QuickSearchManager m) => m.opacity);
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: opacity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: namesList
                  .map(
                    (name) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text(
                        name,
                        style: AppTextStyle.m3BodySmall.copyWith(
                          color: FoodsAppThemeExtension.of(context).onSurface,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
