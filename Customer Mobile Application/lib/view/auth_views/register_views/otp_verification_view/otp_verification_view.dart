import 'package:flutter/material.dart';

import '../../../../shared/size_configuration/text_sizes.dart';
import 'components/otp_verification_view_body.dart';

class OtpVerificationView extends StatefulWidget {
  final int verificationcode;
  final String phoneNumber;
  OtpVerificationView(
      {@required this.phoneNumber, @required this.verificationcode})
      : super();

  @override
  _OtpVerificationViewState createState() => _OtpVerificationViewState();
  static String routeName = 'OtpVerificationView';
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
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
          body: OtpVerificationViewBody(
            verificationcode: widget.verificationcode,
            phoneNumber: widget.phoneNumber,
          ),
        ));
  }
}
