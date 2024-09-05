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
    return Material(
      child: Stack(
        children: [
          Align(
            widthFactor: double.infinity,
            heightFactor: double.infinity,
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FoodSearchPage())),
              child: SvgPicture.string(
                logo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
