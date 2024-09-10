import 'package:flutter/material.dart';
import 'package:foods_app/common/theme.dart';
import 'package:foods_app/features/food_search/managers/food_search_manager.dart';
import 'package:watch_it/watch_it.dart';

class BasePage extends StatefulWidget {
  const BasePage({
    super.key,
    this.showSliverAppBar = true,
    this.additionalSlivers,
    this.onSearchTermChanged,
    this.onClearSearch,
    this.onTap,
  });

  final bool showSliverAppBar;
  final List<Widget>? additionalSlivers;
  final VoidCallback? onSearchTermChanged;
  final VoidCallback? onClearSearch;
  final VoidCallback? onTap;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final TextEditingController _controllerText = TextEditingController();
  final ScrollController _controllerScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.onSearchTermChanged != null) {
      _controllerText.addListener(widget.onSearchTermChanged!);
    }
    if (widget.onTap != null) {
      _controllerScroll.addListener(widget.onTap!);
    }
  }

  @override
  void dispose() {
    if (widget.onSearchTermChanged != null) {
      _controllerText.removeListener(widget.onSearchTermChanged!);
    }
    _controllerText.dispose();
    _controllerScroll.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _controllerText.clear();
    if (widget.onClearSearch != null) {
      widget.onClearSearch!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controllerScroll,
        slivers: [
          if (widget.showSliverAppBar)
            SliverAppBar(
              surfaceTintColor: AppColorsExtension.of(context).surfaceTint,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                      onPressed: _clearSearch,
                      icon: const Icon(Icons.clear_outlined)),
                ),
                const _FoodResultsCountBadge(),
              ],
              floating: true,
              title: TextField(
                controller: _controllerText,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Search for food...',
                ),
              ),
              pinned: true,
            ),
          ...?widget.additionalSlivers,
        ],
      ),
    );
  }
}

class _FoodResultsCountBadge extends WatchingWidget {
  const _FoodResultsCountBadge();

  @override
  Widget build(BuildContext context) {
    final count = watchValue((FoodSearchManager m) => m.currentResults);
    return Badge.count(count: count.length);
  }
}
