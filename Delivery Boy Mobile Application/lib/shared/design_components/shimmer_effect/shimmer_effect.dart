import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatefulWidget {
  ShimmerEffect({@required this.child, this.enabled}) : super();
  final Widget child;
  final bool enabled;
  @override
  _ShimmerEffectState createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
direction:ShimmerDirection.rtl ,
period:Duration(seconds:1) ,
    baseColor: Colors.grey[100].withOpacity(.1),
                highlightColor: Colors.grey[300],
        // 
        enabled: true,
        child: widget.child);
  }
}
