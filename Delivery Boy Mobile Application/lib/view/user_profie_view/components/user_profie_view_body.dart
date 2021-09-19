import 'package:community_material_icon/community_material_icon.dart';
import 'package:delivery_boy_application/controllers/zone_name_controller/zone_name_controller.dart';
import 'package:delivery_boy_application/models/zone_name_model.dart';
import 'package:delivery_boy_application/shared/functional_components/current_user_components.dart';
import 'package:flutter/material.dart';

import '../../../shared/design_components/custom_elevated_button/custom_elevated_button.dart';
import '../../../shared/design_components/custom_textfield/custom_textfield.dart';
import '../../../shared/size_configuration/size_config.dart';
import '../../../shared/size_configuration/text_sizes.dart';

class UserProfieViewBody extends StatefulWidget {
  final bool isEditing;
  UserProfieViewBody(this.isEditing) : super();

  @override
  _UserProfieViewBodyState createState() => _UserProfieViewBodyState();
}

class _UserProfieViewBodyState extends State<UserProfieViewBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: getProportionateScreenWidth(300),
        height: SizeConfiguration.screenHeight * .85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          textDirection: TextDirection.rtl,
          children: [
            buildProfileImageAvatar(isEditing: widget.isEditing),
            SizedBox(
              height: getProportionateScreenWidth(15),
            ),
            CustomTextFeild(
              onChanged: (n) {},
              readOnly: !widget.isEditing,
              prefixIcon: CommunityMaterialIcons.account_outline,
              rightContentPadding: 1,
              hintText: 'محمد',
              enableInteractiveSelection: !widget.isEditing,
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
              hintText: gbDeliveryBoyModel.phoneNumber,
            ),
            SizedBox(
              height: getProportionateScreenWidth(15),
            ),
            FutureBuilder<ZoneNameModel>(
                future: ZoneNameController.getZoneFromId(
                    gbDeliveryBoyModel.zoneNameId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return CustomTextFeild(
                      onChanged: (txt) {},

                      readOnly: !widget.isEditing,
                      // readOnly: isEditing,
                      prefixIcon:
                          CommunityMaterialIcons.map_marker_radius_outline,
                          
                      rightContentPadding: 1,

                      hintText: 'جاري التحميل ..',
                    );
                  }
                  return CustomTextFeild(
                    onChanged: (txt) {},
                    readOnly: !widget.isEditing,
                    prefixIcon:
                        CommunityMaterialIcons.map_marker_radius_outline,
                    rightContentPadding: 1,
                    hintText: snapshot.data.zoneName,
                  );
                }),
            SizedBox(
              height: getProportionateScreenWidth(15),
            ),
            widget.isEditing
                ? CustomElevatedButton(
                    child: Text(
                      'تعديل',
                      style: Theme.of(context).textTheme.button.copyWith(
                          fontFamily: 'Almarai',
                          fontSize: TextSizes.button,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      setState(
                          () {}); //TODO: Functional code for edit profile Data
                    },
                    buttonheight: 53.3,
                    buttonWidth: double.infinity,
                  )
                : SizedBox()
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
                  image: NetworkImage(
                    gbDeliveryBoyModel.portraitImageURL,
                  ),
                ),
              ),
            ),
          ),
          isEditing
              ? Positioned(
                  bottom: getProportionateScreenWidth(0),
                  right: getProportionateScreenWidth(0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(CommunityMaterialIcons.pencil_outline),
                    style: ElevatedButton.styleFrom(shape: CircleBorder()),
                  ))
              : SizedBox()
        ],
      ),
    );
  }
}
