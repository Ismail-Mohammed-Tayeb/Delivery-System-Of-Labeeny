import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/design_components/custom_notification/custom_notification.dart';
import '../../../../../shared/design_components/custom_pin_code_fields/custom_pin_code_fields.dart';
import '../../../../../shared/design_components/custom_toast/customSnackBar.dart';
import '../../../../../shared/functional_components/current_user_components.dart';
import '../../../../../shared/size_configuration/size_config.dart';
import '../../../../../shared/size_configuration/text_sizes.dart';
import '../../data_completion_view/data_completion_view.dart';

class OtpVerificationViewBody extends StatefulWidget {
  final int verificationcode;
  final String phoneNumber;
  OtpVerificationViewBody(
      {@required this.verificationcode, @required this.phoneNumber})
      : super();

  @override
  _OtpVerificationViewBodyState createState() =>
      _OtpVerificationViewBodyState();
}

class _OtpVerificationViewBodyState extends State<OtpVerificationViewBody> {
  @override
  Widget build(BuildContext context) {
    int verfCode = widget.verificationcode;
    return Center(
      child: Container(
        width: getProportionateScreenWidth(350),
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'تم ارسال رمز التحقق للرقم',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.body1,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              widget.phoneNumber,
              style: Theme.of(context).textTheme.headline4.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.headline4,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            CustomPinCodeFields(
              onComplete: (code) {
                //TODO: Later be replaced with real phone authentication
                //Verifing the sent code with the input code as OTP
                // print(code.toString());
                if (code != verfCode.toString()) {
                  showCustomSnackBar(
                      'تنبيه!',
                      'رقم التحقق غير صحيح',
                      Icon(
                        CommunityMaterialIcons.alert_circle_outline,
                        color: Theme.of(context).errorColor,
                      ),
                      context);

                  return;
                }
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DataCompletionView(phoneNumber: widget.phoneNumber),
                    ),
                    (route) => false);
              },
            ),
            InkWell(
              onTap: () async {
                int code = int.parse(
                  await authenticationController
                      .checkPhoneAvailability(widget.phoneNumber),
                );
                verfCode = code;
                showCustomNotificationLocal(
                  verfCode.toString(),
                );
              },
              child: Text(
                'إعادة ارسال رمز التحقق\n',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.body1,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
