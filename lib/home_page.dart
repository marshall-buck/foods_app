import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foods_app/common/constants.dart';

import 'package:foods_app/common/theme.dart';

import 'package:foods_app/features/food_search/managers/search_delegate.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final searchBar = SearchBar(
      hintText: 'Search For Foods',
      backgroundColor: WidgetStateProperty.all(colors.surfaceContainer),
      onTap: () => showSearch(
        context: context,
        delegate: FoodSearchDelegate(),
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ClipRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 11.4, sigmaY: 11.4),
                      child: Image.asset(
                        orangesImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ClipRect(
                    child: Opacity(
                      opacity: 0.5,
                      child: ImageFiltered(
                        imageFilter:
                            ImageFilter.blur(sigmaX: 11.4, sigmaY: 11.4),
                        child: Image.asset(
                          appleImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Center(
                child: searchBar,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
