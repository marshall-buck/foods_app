import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/features/food_search/food_search.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Align(
        widthFactor: double.infinity,
        heightFactor: double.infinity,
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<FoodSearchPage>(
              builder: (context) => const FoodSearchPage(),
            ),
          ),
          child: SvgPicture.string(
            logoString,
          ),
        ),
      ),
    );
  }
}
