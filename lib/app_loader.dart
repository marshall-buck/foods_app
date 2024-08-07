import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foods_app/common/zcommon.dart';
import 'package:watch_it/watch_it.dart';

import 'features/food_search/food_search_bar.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: di.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRect(
                      child: ImageFiltered(
                        imageFilter:
                            ImageFilter.blur(sigmaX: 11.4, sigmaY: 11.4),
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
              const Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Center(
                  child: FoodSearchBar(),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          print('Snapshot error from LoadingWidget : ${snapshot.error}');
          print(
              'Snapshot stacktrace from LoadingWidget: ${snapshot.stackTrace}');
          return Column(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error from LoadingWidget: ${snapshot.error}'),
              ),
            ],
          );
        } else {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Text('Awaiting result...')
              ],
            ),
          );
        }
      },
    );
  }
}
