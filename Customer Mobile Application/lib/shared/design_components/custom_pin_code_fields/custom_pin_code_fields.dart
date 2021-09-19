import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../size_configuration/text_sizes.dart';

class CustomPinCodeFields extends StatelessWidget {
  final Function(String) onComplete;
  final Function(String) onSubmitted;
  CustomPinCodeFields({this.onComplete, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
        onSubmitted: onSubmitted,
        backgroundColor: Colors.transparent,
        onChanged: (value) {
          print(value);
        },
        appContext: context,
  
        length: 6,
        animationType: AnimationType.fade,
        keyboardType: TextInputType.number,
        textStyle: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: TextSizes.headline6,
              fontFamily: 'Almarai',
            ),

        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(20),
          fieldHeight: 50,
          fieldWidth: 50,
          inactiveColor: Theme.of(context).colorScheme.secondary,
          activeColor: Theme.of(context).colorScheme.secondary,
          selectedColor: Theme.of(context).colorScheme.secondary,
        ),
        onCompleted: onComplete);
  }
}
