import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../../shared/design_components/custom_elevated_button/custom_elevated_button.dart';
import '../../../../../shared/design_components/custom_notification/custom_notification.dart';
import '../../../../../shared/design_components/custom_textfield/custom_textfield.dart';
import '../../../../../shared/design_components/custom_toast/customSnackBar.dart';
import '../../../../../shared/functional_components/current_user_components.dart';
import '../../../../../shared/functional_components/regular_expressions.dart';
import '../../../../../shared/size_configuration/size_config.dart';
import '../../../../../shared/size_configuration/text_sizes.dart';
import '../../../login_view/login_view.dart';
import '../../otp_verification_view/otp_verification_view.dart';

class PhoneNumberRegisterViewBody extends StatefulWidget {
  PhoneNumberRegisterViewBody({Key key}) : super(key: key);

  @override
  _PhoneNumberRegisterViewBodyState createState() =>
      _PhoneNumberRegisterViewBodyState();
}

class _PhoneNumberRegisterViewBodyState
    extends State<PhoneNumberRegisterViewBody> {
  String _phoneNumber;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          // color: Colors.red.withOpacity(0.2),
          width: getProportionateScreenWidth(350),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: [
                Container(
                  width: SizeConfiguration.screenWidth * .8,
                  height: SizeConfiguration.screenWidth * .8,
                  child: Image.asset(
                    'assets/images/Logo_labeeny_black.png',
                    color: Theme.of(context).accentColor,
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
                CustomTextFeild(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  obscureText: false,
                  lableText: 'رقم الهاتف',
                  hintText: 'رقم الهاتف',
                  onChanged: (txt) {
                    if (regexPhoneNumber.hasMatch(txt)) {
                      _phoneNumber = txt;
                      return;
                    }
                    _phoneNumber = null;
                  },
                ),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
                CustomElevatedButton(
                  buttonWidth: 400,
                  buttonheight: 50,
                  //Calling the method to make register new phone number
                  onPressed: checkPhoneAvailability,
                  child: Text(
                    'إرسال رمز التحقق',
                    style: Theme.of(context).textTheme.button.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.button,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigator.pushReplacementNamed(LoginView.routeName);
                      },
                      child: Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('لدّي حساب؟',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.body2)),
                          SizedBox(
                            width: getProportionateScreenWidth(6),
                          ),
                          Text(
                            'تسجيل الدخول',
                            style:
                                Theme.of(context).textTheme.overline.copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.body2,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }

  checkPhoneAvailability() async {
    if (_phoneNumber == null) {
      showCustomSnackBar(
          'تنبيه!',
          'يرجى ملئ رقم الهاتف برقم موجود',
          Icon(
            CommunityMaterialIcons.alert_circle_check_outline,
            color: Theme.of(context).errorColor,
          ),
          context);

      return;
    }
    var authenticationResult =
        await authenticationController.checkPhoneAvailability(_phoneNumber);

    try {
      int authenticationCode = int.parse(authenticationResult.toString());
      //If code reaches here then the code was recievied successfully since
      //The api might return a string and cast exception will occure
      showCustomNotificationLocal(authenticationCode.toString());
      navigator.pushReplacement(
        MaterialPageRoute(builder: (context) {
          return OtpVerificationView(
            verificationcode: authenticationCode,
            phoneNumber: _phoneNumber,
          );
        }),
      );
    } catch (e) {
      print(authenticationResult.toString());
      showCustomSnackBar(
          'تنبيه!',
          authenticationResult.toString(),
          Icon(
            CommunityMaterialIcons.alert_circle_check_outline,
            color: Theme.of(context).errorColor,
          ),
          context);
    }
  }
}
