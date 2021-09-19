import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../controllers/authentication_controllers/auth_controller.dart';
import '../../../../../controllers/location_controllers/geo_location_controller.dart';
import '../../../../../models/customer_model.dart';
import '../../../../../models/exported_models.dart';
import '../../../../../shared/design_components/custom_elevated_button/custom_elevated_button.dart';
import '../../../../../shared/design_components/custom_textfield/custom_textfield.dart';
import '../../../../../shared/design_components/custom_toast/customSnackBar.dart';
import '../../../../../shared/functional_components/current_user_components.dart';
import '../../../../../shared/functional_components/regular_expressions.dart';
import '../../../../../shared/size_configuration/size_config.dart';
import '../../../../../shared/size_configuration/text_sizes.dart';
import '../../../../wrapper_view/wrapper_view.dart';

class DataCompletionViewBody extends StatefulWidget {
  final String phoneNumber;
  DataCompletionViewBody({@required this.phoneNumber}) : super();

  @override
  _DataCompletionViewBodyState createState() => _DataCompletionViewBodyState();
}

class _DataCompletionViewBodyState extends State<DataCompletionViewBody> {
  bool checkBoxIsSelected = false, isLoading = false;
  String _fullName, _password;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Center(
        child: Container(
          // color: Colors.red.withOpacity(0.2),
          width: getProportionateScreenWidth(350),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: getProportionateScreenHeight(300),
                      height: getProportionateScreenHeight(300),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor.withOpacity(.8),
                        shape: BoxShape.circle,
                        image: _userImage == null
                            ? null
                            : DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(_userImage),
                              ),
                      ),
                      child: _userImage == null
                          ? Icon(
                              Icons.add_a_photo_outlined,
                              color: Theme.of(context).primaryColor,
                              size: getProportionateScreenHeight(200),
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: ElevatedButton(
                        onPressed: _getImageFromImagePicker,
                        child: Icon(Icons.camera_alt_rounded),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenWidth(20)),
              CustomTextFeild(
                keyboardType: TextInputType.name,
                lableText: 'الإسم الكامل',
                obscureText: false,
                onChanged: (txt) {
                  if (txt.length == 0) _fullName = null;
                  _fullName = txt.trim();
                },
                textInputAction: TextInputAction.next,
                hintText: 'الإسم الكامل',
                // textEditingController: ,
              ),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              CustomTextFeild(
                keyboardType: TextInputType.visiblePassword,
                lableText: 'كلمة المرور',
                obscureText: true,
                onChanged: (txt) {
                  if (regexStrongPassword.hasMatch(txt)) {
                    _password = txt.trim();
                    return;
                  }
                  _password = null;
                },
                textInputAction: TextInputAction.next,
                hintText: 'كلمة المرور',
                // textEditingController: ,
              ),
              SizedBox(
                height: getProportionateScreenWidth(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() => checkBoxIsSelected = !checkBoxIsSelected);
                    },
                    child: Row(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: checkBoxIsSelected,
                          onChanged: (newValue) {
                            setState(() => checkBoxIsSelected = newValue);
                          },
                          activeColor: Theme.of(context).colorScheme.secondary,
                        ),
                        Text(
                          'السماح بتحديد موقعي الحالي',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontFamily: 'Almarai',
                                fontSize: TextSizes.body2,
                                fontWeight:
                                    checkBoxIsSelected ? FontWeight.bold : null,
                              ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isLoading
                  ? Center(
                      child: Container(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : CustomElevatedButton(
                      buttonWidth: 400,
                      buttonheight: 50,
                      onPressed: registerNewCustomer,
                      child: Text(
                        'إنشاء الحساب',
                        style: Theme.of(context).textTheme.button.copyWith(
                            fontFamily: 'Almarai',
                            fontSize: TextSizes.button,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
              SizedBox(height: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ),
    );
  }

  registerNewCustomer() async {
    setState(() {
      isLoading = true;
    });
    //Making sure that the fullname or password are not null
    //if so then the user can register successfully
    if (_fullName == null || _password == null) {
      showCustomSnackBar(
          'تنبيه!',
          'لإسم/كلمة المرور غير صالحة',
          Icon(
            CommunityMaterialIcons.alert_circle_outline,
            color: Theme.of(context).errorColor,
          ),
          context);
      setState(() {
        isLoading = false;
      });
      return;
    }
    CustomerModel toRegisterWith = CustomerModel(
      //This userid will not be read from database so its unnecessary
      userId: 0,
      phoneNumber: widget.phoneNumber,
      password: _password,
      name: _fullName,
      portraitImageURL: 'null',
      userType: 3,
      location: await GeoLocationApiController.getCurrentLocation(),
    );
    print('To REgister With Obj ${toRegisterWith.toMap()}');
    try {
      var res =
          await authenticationController.registerNewCustomer(toRegisterWith);
      print('Register Result is : $res');
      if (!(res is bool)) {
        showCustomSnackBar(
            'تنبيه!',
            'حدث خطأ يرجى إعادةالمحاولة',
            Icon(
              CommunityMaterialIcons.alert_circle_outline,
              color: Theme.of(context).errorColor,
            ),
            context);
        setState(() {
          isLoading = false;
        });
        return;
      }
      if (_userImage != null) {
        dynamic imageRes =
            await AuthenticationController().uploadPortraitImage(_userImage);
        if (!(imageRes is bool)) {
          showCustomSnackBar(
              'تنبيه!',
              '$imageResحدث خطأ يرجى إعادةالمحاولة',
              Icon(
                CommunityMaterialIcons.alert_circle_outline,
                color: Theme.of(context).errorColor,
              ),
              context);
          setState(() {
            isLoading = false;
          });
          return;
        }
      }
      await AuthenticationController().loginUser(widget.phoneNumber, _password);
      setState(() {
        isLoading = false;
      });
      //Navigate to HomeScreen
      navigator.pushReplacementNamed(WrapperView.routeName);
    } catch (e) {
      showCustomSnackBar(
          'تنبيه!',
          '$eحدث خطأ يرجى إعادةالمحاولة',
          Icon(
            CommunityMaterialIcons.alert_circle_outline,
            color: Theme.of(context).errorColor,
          ),
          context);
      setState(() {
        isLoading = false;
      });
    }
  }

  //This is the helping method to get the image from gallery or camera
  File _userImage;
  final picker = ImagePicker();

  void _getImageFromImagePicker() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _userImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
