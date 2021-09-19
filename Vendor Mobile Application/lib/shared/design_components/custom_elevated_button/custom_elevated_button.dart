import 'package:flutter/material.dart';

import '../../size_configuration/size_config.dart';

class CustomElevatedButton extends StatelessWidget {
  final double buttonWidth;
  final double buttonheight;

  final Widget child;
  final Function onPressed;
  const CustomElevatedButton(
      {
      @required this.buttonWidth,
      @required this.child,
      @required this.onPressed,
      @required this.buttonheight})
      : super();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(buttonWidth),
      height: getProportionateScreenWidth(buttonheight),
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
