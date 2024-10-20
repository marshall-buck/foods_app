import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/features.dart';
import 'package:foods_app/widgets/widgets.dart';
import 'package:watch_it/watch_it.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    required this.showBadge,
    this.titleString,
    this.hintText,
    this.onTap,
    this.onClearSearch,
    this.onChanged,
    this.searchController,
    super.key,
  });
  final TextEditingController? searchController;
  final String? titleString;

  final bool showBadge;

  final String? hintText;

  final GestureTapCallback? onTap;
  final VoidCallback? onClearSearch;

  final ValueChanged<String>? onChanged;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
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
  Widget build(BuildContext context) {
    return SliverAppBar(
      // surfaceTintColor: FAppThemeExt.of(context).surfaceTint,
      expandedHeight: kToolbarHeight + 32,
      automaticallyImplyLeading: false,
      floating: true,
      // snap: true,
      // backgroundColor: Colors.transparent,
      title: titleString != null
          ? Text(titleString!)
          : Hero(
              tag: MagicStrings.searchBarHeroTag,
              child: FoodsAppSearchBar(
                showBadge: showBadge,
                hintText: hintText ?? MagicStrings.searchPageHintText,
                onTap: onTap,
                onClearSearch: onClearSearch,
                onChanged: onChanged,
                controller: searchController,
              ),
            ),
      flexibleSpace: titleString == null ? const _QuickSearchHeader() : null,
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
                          color: Theme.of(context).colorScheme.onSurface,
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
