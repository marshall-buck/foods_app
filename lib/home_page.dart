import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foods_app/common/constants.dart';
import 'package:foods_app/common/text_styles.dart';
import 'package:foods_app/common/theme.dart';

import 'package:foods_app/features/food_search/managers/search_delegate.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('building HomePage');
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
      // appBar: AppBar(
      //   title: Text(
      //     'Title',
      //     style: AppTextStyle.m3HeadlineLarge,
      //   ),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            // Column(
            //   children: [
            //     Expanded(
            //       child: Center(
            //         child: searchBar,
            //       ),
            //     ),
            //   ],
            // ),
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

class FromFigma extends StatelessWidget {
  const FromFigma({
    super.key,
    required this.searchBar,
  });

  final SearchBar searchBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 720,
      child: Stack(
        children: [
          Positioned(
            left: -1,
            top: 353,
            child: Opacity(
              opacity: 0.50,
              child: Container(
                width: 375,
                height: 353,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/375x353"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Opacity(
              opacity: 0.50,
              child: Container(
                width: 375,
                height: 353,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/375x353"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: searchBar,
          )
        ],
      ),
    );
  }
}
