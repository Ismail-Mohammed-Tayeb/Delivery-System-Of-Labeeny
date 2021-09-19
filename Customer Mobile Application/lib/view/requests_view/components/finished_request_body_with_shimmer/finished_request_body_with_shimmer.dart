import 'package:flutter/material.dart';

import '../../../../shared/design_components/shimmer_effect/shimmer_effect.dart';
import '../../../../shared/size_configuration/size_config.dart';

class FinishedRequestBodyWithShimmer extends StatefulWidget {
  FinishedRequestBodyWithShimmer({Key key}) : super(key: key);

  @override
  _FinishedRequestBodyWithShimmerState createState() =>
      _FinishedRequestBodyWithShimmerState();
}

class _FinishedRequestBodyWithShimmerState
    extends State<FinishedRequestBodyWithShimmer> {
  //TODO: Design Theme This Method For Dark Mode !!
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      elevation: 3,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: getProportionateScreenWidth(150),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[400]
                            : Colors.grey[300],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[400]
                            : Colors.grey[300],
                        height: getProportionateScreenWidth(20),
                        width: getProportionateScreenWidth(100),
                      ),
                      SizedBox(
                        height: getProportionateScreenWidth(5),
                      ),
                      Container(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[400]
                            : Colors.grey[300],
                        height: getProportionateScreenWidth(20),
                        width: getProportionateScreenWidth(280),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            child: Container(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[400]
                  : Colors.grey[300],
              height: getProportionateScreenWidth(20),
              width: getProportionateScreenWidth(100),
            ),
          ),
          ShimmerEffect(
            enabled: true,
            child: Container(
              width: double.infinity,
              height: getProportionateScreenWidth(150),
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
