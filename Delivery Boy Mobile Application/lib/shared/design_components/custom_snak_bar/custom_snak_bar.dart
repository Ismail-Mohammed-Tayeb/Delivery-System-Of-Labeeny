import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../size_configuration/size_config.dart';

//Add Context If Required
customSnackBar(String title, String message, Icon icon, BuildContext context,
    [String buttonTxt, Function onPressed]) {
  Get.snackbar(
 
 
    title,
    message,
    backgroundColor: Theme.of(context).primaryColor,
    shouldIconPulse: true,
    
    snackPosition: SnackPosition.BOTTOM,
    icon: icon,
    boxShadows: [
      BoxShadow(
        color: Colors.black.withOpacity(.1),
        blurRadius: 2.5,
        offset: Offset(0, 1),
      )
    ],
    colorText: Theme.of(context).textTheme.bodyText1.color,
    borderRadius: getProportionateScreenWidth(0),
    maxWidth: double.infinity,
    mainButton: onPressed == null
        ? null
        : TextButton(
            child: Text(buttonTxt),
            onPressed: onPressed,
          ),

  );
}
