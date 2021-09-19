import 'package:flutter/material.dart';

import '../../../../shared/design_components/shimmer_effect/shimmer_effect.dart';
import '../../../../shared/size_configuration/size_config.dart';

class StoreProductViewBodyWithShimmer extends StatefulWidget {
  StoreProductViewBodyWithShimmer({Key key}) : super(key: key);

  @override
  _StoreProductViewBodyWithShimmerState createState() =>
      _StoreProductViewBodyWithShimmerState();
}

class _StoreProductViewBodyWithShimmerState
    extends State<StoreProductViewBodyWithShimmer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: getProportionateScreenWidth(140),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[400]
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: Offset(0, 1),
                blurRadius: 2.5,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                flex: 0,
                child: Column(
                  children: [
                    Container(
                      width: getProportionateScreenWidth(140),
                      height: getProportionateScreenWidth(140),
                      decoration: BoxDecoration(
                        // color: Colors.transparent,
                        borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(
                            getProportionateScreenWidth(25),
                          ),
                          bottomEnd: Radius.circular(
                            getProportionateScreenWidth(25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(7)),
                  width: getProportionateScreenWidth(240),
                  height: double.infinity,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: Column(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: getProportionateScreenWidth(240),
                        height: getProportionateScreenWidth(20),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[400]
                            : Colors.grey[300],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: getProportionateScreenWidth(220),
                        height: getProportionateScreenWidth(20),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[400]
                            : Colors.grey[300],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: getProportionateScreenWidth(80),
                        height: getProportionateScreenWidth(20),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[400]
                            : Colors.grey[300],
                      ),
                      Spacer(),
                      Container(
                        width: getProportionateScreenWidth(60),
                        height: getProportionateScreenWidth(20),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[400]
                            : Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ShimmerEffect(
          enabled: true,
          child: Container(
            width: double.infinity,
            height: getProportionateScreenWidth(140),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(getProportionateScreenWidth(25))),
          ),
        )
      ],
    );
  }
}
