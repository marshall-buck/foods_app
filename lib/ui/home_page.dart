import 'package:flutter/material.dart';
import 'package:foods_app/common/constants.dart';
import 'package:foods_app/data/data_B.dart';
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
          print('returning HomePage:  ${snapshot.data}');
          return const HomePage();
        } else if (snapshot.hasError) {
          print('Snapshot error: ${snapshot.error}');
          return Column(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
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
  Future<List<FoodModel?>> _queryFoods(String searchTerm) async {
    final db = await di.getAsync<FoodsDBInterface>(
        instanceName: LocatorName.foodsDBService.name);
    final foods = await db.queryFoods(searchTerm: searchTerm.trim());
    print(foods);
    return foods;
  }

  @override
  Widget build(BuildContext context) {
    print('building HomePage');
    // late final colors = Theme.of(context).extension<AppColorsExtension>();
    // late final FoodsDBInterface db = di.get<FoodsDBInterface>(
    //     instanceName: ServiceInstance.foodsDBService.string);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello World!',
            ),
            SearchBar(
              onTap: () async => await _queryFoods('apple'),
            ),
          ],
        ),
      ),
    );
  }
}
