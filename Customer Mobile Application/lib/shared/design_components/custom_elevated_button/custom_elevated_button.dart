import 'package:flutter/material.dart';

import '../../size_configuration/size_config.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key key,
      this.buttonWidth,
      this.child,
      this.onPressed,
      this.buttonheight})
      : super(key: key);

  final double buttonWidth;
  final double buttonheight;

  final Widget child;
  final Function onPressed;
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
