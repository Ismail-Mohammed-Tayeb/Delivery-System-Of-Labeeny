import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/authentication_controllers/auth_controller.dart';
import '../../../controllers/user_data_controller/user_data_controller.dart';
import '../../../shared/design_components/custom_elevated_button/custom_elevated_button.dart';
import '../../../shared/design_components/custom_progress_indicator/custom_progress_indicator.dart';
import '../../../shared/design_components/custom_textfield/custom_textfield.dart';
import '../../../shared/functional_components/current_user_components.dart';
import '../../../shared/size_configuration/size_config.dart';
import '../../../shared/size_configuration/text_sizes.dart';

class UserProfieViewBody extends StatefulWidget {
  final bool isEditing;
  UserProfieViewBody(this.isEditing) : super();

  @override
  _UserProfieViewBodyState createState() => _UserProfieViewBodyState();
}

class _UserProfieViewBodyState extends State<UserProfieViewBody> {
  String _name;
  File _userImage;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: getProportionateScreenWidth(300),
        child: Column(
          textDirection: TextDirection.rtl,
          children: [
            buildProfileImageAvatar(isEditing: widget.isEditing),
            SizedBox(
              height: getProportionateScreenWidth(15),
            ),
            CustomTextFeild(
              onChanged: (txt) {
                if (txt.trim().length == 0) {
                  _name = null;
                  return;
                }
                _name = txt.trim();
              },
              readOnly: !widget.isEditing,
              prefixIcon: CommunityMaterialIcons.account_outline,
              rightContentPadding: 1,
              hintText: gbCustomerModel.name,
              enableInteractiveSelection: !widget.isEditing,
            ),
            SizedBox(
              height: getProportionateScreenWidth(15),
            ),
            CustomTextFeild(
              onChanged: (n) {},
              readOnly: !widget.isEditing,
              // readOnly: isEditing,
              prefixIcon: CommunityMaterialIcons.lock_outline,
              rightContentPadding: 1,
              hintText: '••••••••••••••••',
            ),
            SizedBox(
              height: getProportionateScreenWidth(15),
            ),
            CustomTextFeild(
              onChanged: (n) {},
              readOnly: !widget.isEditing,
              // readOnly: isEditing,
              prefixIcon: CommunityMaterialIcons.phone_outline,
              rightContentPadding: 1,
              hintText: gbCustomerModel.phoneNumber,
            ),
            SizedBox(
              height: getProportionateScreenWidth(15),
            ),
            CustomTextFeild(
              onChanged: (n) {},

              readOnly: !widget.isEditing,
              // readOnly: isEditing,
              prefixIcon: CommunityMaterialIcons.map_marker_radius_outline,
              rightContentPadding: 1,
              hintText: gbCustomerModel.location.toString(),
            ),
            SizedBox(
              height: getProportionateScreenWidth(15),
            ),
            isLoading
                ? CustomCircularProgressIndicator()
                : (widget.isEditing
                    ? CustomElevatedButton(
                        child: Text(
                          'تعديل',
                          style: Theme.of(context).textTheme.button.copyWith(
                              fontFamily: 'Almarai',
                              fontSize: TextSizes.button,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: _updateUserData,
                        buttonheight: 53.3,
                        buttonWidth: double.infinity,
                      )
                    : SizedBox())
          ],
        ),
      ),
    );
  }

  Widget buildProfileImageAvatar({bool isEditing}) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            radius: getProportionateScreenHeight(130),
            child: Container(
              width: getProportionateScreenHeight(250),
              height: getProportionateScreenHeight(250),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: _userImage == null
                      ? (gbCustomerModel.portraitImageURL == 'null'
                          ? Icon(Icons.person)
                          : NetworkImage(gbCustomerModel.portraitImageURL))
                      : FileImage(_userImage),
                ),
              ),
            ),
          ),
          isEditing
              ? Positioned(
                  bottom: getProportionateScreenWidth(0),
                  right: getProportionateScreenWidth(0),
                  child: ElevatedButton(
                    onPressed: _getImageFromImagePicker,
                    child: Icon(CommunityMaterialIcons.pencil_outline),
                    style: ElevatedButton.styleFrom(shape: CircleBorder()),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }

  //This is the helping method to get the image from gallery or camera
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

  _updateUserData() async {
    if (_name == null && _userImage == null) {
      print('Both Name And Image Are Null .. Leaving Method');
      //TODO: Design Show Error Message Here
      return;
    }
    print('User Id Is ${gbCustomerModel.userId}');
    setState(() {
      isLoading = !isLoading;
    });
    //TODO: Edit User Profile Data Here
    if (_name == null) {
      //This means if no new name was entered than the username isn't updated
      _name = gbCustomerModel.name;
      print('name is null');
    }
    bool updateRes;
    if (_userImage == null) {
      print('Entered Here For No Image Update Only Name');
      updateRes = await UserDataController.updateUserData(_name);
      print('updateRes = $updateRes');
      if (updateRes != null && updateRes == true) {
        //TODO: Design Show Toast That successfully Updated Data Then setState((){})
        //These two methods are recalled here to update the userdata after the query has
        //been executed
        dynamic userResult = await AuthenticationController().getUserData();
        AuthenticationController()
            .createCustomerModel((userResult as List).first);
        setState(() {
          isLoading = false;
        });
      }
      //TODO: Design Show Toast Error when Updating Data
      setState(() {
        isLoading = false;
      });
      return;
    }
    print('Entered Here For Image Update And Name');
    updateRes = await UserDataController.updateUserData(_name, _userImage);
    print('updateRes = $updateRes');

    if (updateRes != null && updateRes == true) {
      //TODO: Design Show Toast That successfully Updated Data Then setState((){})
      //These two methods are recalled here to update the userdata after the query has
      //been executed
      dynamic userResult = await AuthenticationController().getUserData();
      AuthenticationController()
          .createCustomerModel((userResult as List).first);
      setState(() {
        isLoading = false;
      });
    }
    //TODO: Design Show Toast Error when Updating Data
    setState(() {
      isLoading = false;
    });
  }
}
