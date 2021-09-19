import 'package:flutter/material.dart';

import '../../size_configuration/size_config.dart';
import '../../size_configuration/text_sizes.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
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
      child: OutlinedButton(
        onPressed: onPressed,
        child: child,
        style: OutlinedButton.styleFrom(
            textStyle: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.red, fontSize: TextSizes.button)),
      ),
    );
  }
}
