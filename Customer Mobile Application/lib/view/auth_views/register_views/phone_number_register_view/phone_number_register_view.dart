import 'package:flutter/material.dart';

import '../../../../shared/size_configuration/text_sizes.dart';
import 'components/phone_number_register_view_body.dart';

class PhoneNumberRegisterView extends StatefulWidget {
  const PhoneNumberRegisterView({Key key}) : super(key: key);
  static String routeName = 'PhoneNumberRegisterView';

  @override
  _PhoneNumberRegisterViewState createState() =>
      _PhoneNumberRegisterViewState();
}

class _PhoneNumberRegisterViewState extends State<PhoneNumberRegisterView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
        data: Theme.of(context),
        duration: Duration(milliseconds: 500),
        child: Scaffold(
          appBar: AppBar(
            title: Text('انشاء حساب',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.headline6,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15)),
          ),
          body: PhoneNumberRegisterViewBody(),
        ));
  }
}
