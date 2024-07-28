import 'package:flutter/material.dart';
import 'package:foods_app/home_page.dart';
import 'package:watch_it/watch_it.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // print('build widget');
    return FutureBuilder(
      future: di.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // print('FutureBuilder');
        if (snapshot.hasData) {
          // print('returning HomePage');
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
          // print('returning CircularProgressIndicator:  ${snapshot}');
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
