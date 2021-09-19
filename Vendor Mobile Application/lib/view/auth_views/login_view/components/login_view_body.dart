import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../controller/authentication_controllers/auth_controller.dart';
import '../../../../controller/store_controller/store_controller.dart';
import '../../../../shared/animation/animation.dart';
import '../../../../shared/design_components/custom_elevated_button/custom_elevated_button.dart';
import '../../../../shared/design_components/custom_textfield/custom_textfield.dart';
import '../../../../shared/functional_components/regular_expressions.dart';
import '../../../../shared/size_configuration/size_config.dart';
import '../../../../shared/size_configuration/text_sizes.dart';
import '../../../wrapper_view/wrapper_view.dart';
import '../../contact_us/contact_us_view.dart';

class LoginViewBody extends StatefulWidget {
  LoginViewBody({Key key}) : super(key: key);

  @override
  _LoginViewBodyState createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  String _phoneNumber;
  String _password;
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
                animationIndex: 0,
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
                        if (txt.trim().length == 0 ||
                            !regexPhoneNumber.hasMatch(txt.trim())) {
                          _phoneNumber = null;
                          return;
                        }
                        _phoneNumber = txt.trim();
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
                        if (txt.trim().length == 0 ||
                            !regexStrongPassword.hasMatch(txt.trim())) {
                          _password = null;
                          return;
                        }
                        _password = txt.trim();
                      },
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: getProportionateScreenWidth(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        textDirection: TextDirection.rtl,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed(ContactUsView.routeName);
                            },
                            child: Text(
                              'هل نسيت كلمة المرور؟',
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  .copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.body2,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              CustomAnimation(
                animationIndex: 2,
                child: CustomElevatedButton(
                  buttonWidth: 400,
                  buttonheight: 50,
                  onPressed: _loginUser,
                  child: Text(
                    'تسجيل الدخول',
                    style: Theme.of(context).textTheme.button.copyWith(
                          fontFamily: 'Almarai',
                          fontSize: TextSizes.button,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              SizedBox(
                width: getProportionateScreenWidth(15),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loginUser() async {
    if (_phoneNumber == null) {
      print('Phone Number Is Null');
      //TODO: Show Custom SnackBar Here With Error Message
      return;
    }
    if (_password == null) {
      //TODO: Show Custom SnackBar Here With Error Message
      print('Password Is Null');
      return;
    }
    try {
      var loginResult =
          await AuthenticationController().loginUser(_phoneNumber, _password);
      bool getStoreRes = await StoreController().fillStoreDataFromVendorId();
      print(getStoreRes);
      if ((loginResult is bool && loginResult != null) && getStoreRes) {
        navigator.pushReplacementNamed(WrapperView.routeName);
        return;
      }

      //If code reaches here then there was an error when trying to configure
      //the login method
      print(loginResult.toString());
    } catch (e) {
      print(e);
      print('حدث خطأ اثناء الارسال يرجى اعادة المحاولة');
    }
  }
}
