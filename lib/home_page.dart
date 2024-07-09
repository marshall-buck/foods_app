import 'package:flutter/material.dart';

import 'package:foods_app/food_search/ui/search_page.dart';

import 'package:watch_it/watch_it.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('build widget');
    return FutureBuilder(
      future: di.allReady(),
      // future: _calculation,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print('FutureBuilder');
        if (snapshot.hasData) {
          print('returning HomePage');
          return const HomePage();
        } else if (snapshot.hasError) {
          print('Snapshot error: ${snapshot.error}');
          print('Snapshot stacktrace: ${snapshot.stackTrace}');
          return Column(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ],
          );
        } else {
          print('returning CircularProgressIndicator:  ${snapshot}');
          return const Column(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ],
          );
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('building HomePage');

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'Hello World!',
            ),
            const SearchPage(),
          ],
        ),
      ),
    );
  }
}
