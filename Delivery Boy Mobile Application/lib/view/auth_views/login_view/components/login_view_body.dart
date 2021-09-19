import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../controllers/authentication_controllers/auth_controller.dart';
import '../../../../controllers/push_notification_controller/push_notofication_controller.dart';
import '../../../../shared/design_components/animation/animation.dart';
import '../../../../shared/design_components/custom_elevated_button/custom_elevated_button.dart';
import '../../../../shared/design_components/custom_textfield/custom_textfield.dart';
import '../../../../shared/design_components/custom_toast/customSnackBar.dart';
import '../../../../shared/functional_components/regular_expressions.dart';
import '../../../../shared/size_configuration/size_config.dart';
import '../../../../shared/size_configuration/text_sizes.dart';
import '../../../wrapper_view/wrapper_view.dart';
import '../../contact_us/contact_us_view.dart';

class LoginViewBody extends StatefulWidget {
  LoginViewBody() : super();

  @override
  _LoginViewBodyState createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  String _password, _phoneNumber;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Center(
        child: Container(
          // color: Colors.red.withOpacity(0.2),
          width: getProportionateScreenWidth(350),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              CustomAnimation(
                child: Container(
                  width: SizeConfiguration.screenWidth * .8,
                  height: SizeConfiguration.screenWidth * .8,
                  child: Image.asset(
                    'assets/images/Logo_labeeny_black.png',
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              CustomAnimation(
                animationIndex: 1,
                child: Column(
                  children: [
                    CustomTextFeild(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      obscureText: false,
                      lableText: 'رقم الهاتف',
                      hintText: 'رقم الهاتف',
                      onChanged: (txt) {
                        //Make sure that the input value of the string meets the specified RegEx
                        //That defines the mobile number
                        (regexPhoneNumber.hasMatch(txt.trim()))
                            ? _phoneNumber = txt.trim()
                            : _phoneNumber = null;
                      },
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                    CustomTextFeild(
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      lableText: 'كلمة المرور',
                      hintText: 'كلمة المرور',
                      onChanged: (txt) {
                        //Make sure that the input value of the string meets the specified RegEx
                        //That defines a  strong password
                        //{contains at least one capital letter and number with lenght >= 8 and <=20 }
                        print(txt);
                        (regexStrongPassword.hasMatch(txt.trim()))
                            ? _password = txt.trim()
                            : _password = null;
                      },
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                  ],
                ),
              ),
              CustomAnimation(
                animationIndex: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        textDirection: TextDirection.rtl,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(ContactUsView.routeName);
                            },
                            child: Text('هل نسيت كلمة المرور؟',
                                style: Theme.of(context)
                                    .textTheme
                                    .overline
                                    .copyWith(
                                        fontFamily: 'Almarai',
                                        fontSize: TextSizes.body2,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                    CustomElevatedButton(
                      buttonWidth: 400,
                      buttonheight: 50,
                      onPressed: loginUser,
                      child: Text(
                        'تسجيل الدخول',
                        style: Theme.of(context).textTheme.button.copyWith(
                            fontFamily: 'Almarai',
                            fontSize: TextSizes.button,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//Login Method To Seperate Concerens Was Written Here
  loginUser() async {
    // if (!await InternetConnectionController.checkInternetConnection()) {
    //   showCustomToast('يرجى ملئ رقم الهاتف برقم موجود');
    //   return;
    // }
    print(_password);
    if (_phoneNumber == null) {
      showCustomSnackBar(
          'تنبيه!',
          'يرجى ملئ رقم الهاتف برقم موجود',
          Icon(
            CommunityMaterialIcons.alert_circle_outline,
            color: Theme.of(context).errorColor,
          ),
          context);

      return;
    } else if (_password == null) {
      showCustomSnackBar(
          'تنبيه!',
          'يرجى إدخال كلمة مرور تحوي رقم وحرف كبير على الأقل ',
          Icon(
            CommunityMaterialIcons.alert_circle_outline,
            color: Theme.of(context).errorColor,
          ),
          context);

      return;
    }
    try {
      //Throwing new excption to test code validaty
      // throw new PlatformException(code: 'code');
      var loginResult =
          await AuthenticationController().loginUser(_phoneNumber, _password);
      if ((loginResult is bool && loginResult != null) == true) {
        //Navigate To MainCategories Page
        navigator.pushReplacementNamed(WrapperView.routeName);
        showCustomSnackBar(
            '',
            'تم تسيجل الدخول بنجاح ',
            Icon(
              CommunityMaterialIcons.check_circle_outline,
              color: Theme.of(context).accentColor,
            ),
            context);
        await PushNotificationController.registerDeviceToken();
        return;
      }
      //if the code reaches here than an error/exception has occured
      showCustomSnackBar(
        'تنبه!',
        loginResult.toString(),
        Icon(
          CommunityMaterialIcons.alert_circle_outline,
          color: Theme.of(context).errorColor,
        ),
        context,
      );
      return;
    } catch (e) {
      showCustomSnackBar(
        'تنبيه!',
        'حدث خطأ اثناء الارسال يرجى اعادة المحاولة ',
        Icon(
          CommunityMaterialIcons.alert_circle_outline,
          color: Theme.of(context).errorColor,
        ),
        context,
      );
    }
  }
}
