import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

import 'home_page.dart';

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
          return const HomePage();
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
                  child: CircularProgressIndicator.adaptive(),
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
