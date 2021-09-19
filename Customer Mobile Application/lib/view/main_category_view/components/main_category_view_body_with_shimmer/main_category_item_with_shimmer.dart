import 'package:flutter/material.dart';

import '../../../../shared/design_components/shimmer_effect/shimmer_effect.dart';
import '../../../../shared/size_configuration/size_config.dart';

class MainCategoryViewBodyWithShimmer extends StatefulWidget {
  MainCategoryViewBodyWithShimmer({Key key}) : super(key: key);

  @override
  _MainCategoryViewBodyWithShimmerState createState() =>
      _MainCategoryViewBodyWithShimmerState();
}

class _MainCategoryViewBodyWithShimmerState
    extends State<MainCategoryViewBodyWithShimmer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: getProportionateScreenWidth(180),
          height: getProportionateScreenHeight(210),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[400]
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onSecondary,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: getProportionateScreenWidth(15),
          right: getProportionateScreenWidth(10),
          child: Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[300]
                : Colors.grey[400],
            width: getProportionateScreenWidth(50),
            height: getProportionateScreenWidth(16),
          ),
        ),
        ShimmerEffect(
          enabled: true,
          child: Container(
            width: getProportionateScreenWidth(180),
            height: getProportionateScreenHeight(210),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
