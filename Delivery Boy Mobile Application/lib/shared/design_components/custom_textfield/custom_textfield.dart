import 'package:flutter/material.dart';

import '../../size_configuration/size_config.dart';
import '../../size_configuration/text_sizes.dart';

class CustomTextFeild extends StatelessWidget {
  final String lableText;
  final String hintText;
  final TextEditingController textEditingController;
  final bool obscureText;
  final Function(String) onChanged;
  final IconData prefixIcon;
  final double rightContentPadding;
  final double bottomContentPadding;

final bool readOnly;
final bool enableInteractiveSelection;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  CustomTextFeild(
      {this.textEditingController,
      this.keyboardType,
      this.obscureText = false,
      @required this.onChanged,
      this.lableText='',
      this.textInputAction,
      this.hintText='',
      this.prefixIcon,
      this.rightContentPadding = 0,
      this.bottomContentPadding = 0, this.readOnly=false, this.enableInteractiveSelection=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          enableInteractiveSelection: enableInteractiveSelection,
          readOnly: readOnly,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: TextSizes.subtitle1,
                fontFamily: 'Almarai',
              ),
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.start,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
              prefixIcon: Icon(prefixIcon,color: Theme.of(context).iconTheme.color,),
              // icon: prefixIcon,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: lableText,
              labelStyle:
                  Theme.of(context).inputDecorationTheme.labelStyle.copyWith(
                        fontSize: TextSizes.headline6,
                        fontFamily: 'Almarai',
                      ),
              hintText: hintText,
              hintStyle:
                  Theme.of(context).inputDecorationTheme.hintStyle.copyWith(
                        fontSize: TextSizes.body2,
                        fontFamily: 'Almarai',
                      ),
              contentPadding: EdgeInsets.only(
                  right: getProportionateScreenWidth(rightContentPadding),
                  bottom: getProportionateScreenWidth(bottomContentPadding))
              //Your Styling Goes Here
              ),
          controller: textEditingController,
          onChanged: onChanged ?? null,
        ),
      ),
    );
  }
}
