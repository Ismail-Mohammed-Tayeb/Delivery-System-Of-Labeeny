import 'package:flutter/material.dart';

import '../../../shared/size_configuration/size_config.dart';
import '../../../shared/size_configuration/text_sizes.dart';

class LoadingScreenViewBody extends StatelessWidget {
  const LoadingScreenViewBody() : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(40),
          ),
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Image.asset(
              'assets/images/Logo_labeeny_black.png',
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        Text(
          'لَـــــــبِّـــــــيــــــنِــــــيْ',
          style: Theme.of(context).textTheme.headline6.copyWith(
              fontFamily: 'Almarai',
              fontSize: TextSizes.headline4,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.15),
        ),
      ],
    );
  }
}
