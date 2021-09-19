import 'package:flutter/material.dart';

import '../../../../shared/design_components/shimmer_effect/shimmer_effect.dart';
import '../../../../shared/size_configuration/size_config.dart';

class PendingRequestBodyWithShimmer extends StatefulWidget {
  PendingRequestBodyWithShimmer({Key key}) : super(key: key);

  @override
  _PendingRequestBodyWithShimmerState createState() =>
      _PendingRequestBodyWithShimmerState();
}

class _PendingRequestBodyWithShimmerState
    extends State<PendingRequestBodyWithShimmer> {
  //TODO: Design Theme This Method For Dark Mode !!
  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.black.withOpacity(.5),
      elevation: 3,
      color: Theme.of(context).primaryColor,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: getProportionateScreenWidth(100),
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
          ShimmerEffect(
            enabled: true,
            child: Container(
              width: double.infinity,
              height: getProportionateScreenWidth(100),
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
