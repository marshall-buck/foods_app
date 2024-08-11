import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foods_app/features/food_search/food_search.dart';

import 'common/common.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FoodSearchPage())),
              child: Expanded(
                child: SvgPicture.string(
                  logo,
                ),
              ),
            ),
          ],
        ),
        // const Padding(
        //   padding: EdgeInsets.only(left: 8, right: 8),
        //   child: Center(
        //     child: FoodSearchPage(),
        //   ),
        // ),
      ],
    );
  }
}
