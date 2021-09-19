import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/location_controllers/geo_location_controller.dart';
import '../../models/exported_models.dart';
import '../../shared/design_components/custom_toast/customSnackBar.dart';
import '../../shared/size_configuration/size_config.dart';
import '../../shared/size_configuration/text_sizes.dart';
import '../maps_view/maps_view.dart';
import 'components/cart_view_body.dart';

class CartView extends StatefulWidget {
  CartView({Key key}) : super(key: key);
  static String routeName = 'CartView';

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: Theme.of(context),
      duration: Duration(milliseconds: 500),
      child: Container(
        width: getProportionateScreenWidth(350),
        height: double.infinity,
        child: Scaffold(
            body: SafeArea(
          child: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0.0,
              floating: true,
              brightness: Theme.of(context).brightness,
              foregroundColor: Colors.red,
              backgroundColor: Theme.of(context).colorScheme.primary,
              expandedHeight: getProportionateScreenWidth(40),
              title: Text(
                'المشتريات',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.headline6,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              actions: [
                buildContainer(),
              ],
            ),
            SliverToBoxAdapter(
              child: CartViewBody(),
            )
          ]),
        )),
      ),
    );
  }

  Container buildContainer() {
    return Container(
      alignment: Alignment.center,
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton(
          isDense: true,
          iconEnabledColor:  Theme.of(context).iconTheme.color,
          underline: SizedBox(
            height: 0,
          ),
          hint: Center(child: Text('الموقع')),
          dropdownColor: Theme.of(context).primaryColor,
          value: _value,
          items: [
            DropdownMenuItem(
              child: Row(
                children: [
                  Icon(
                    CommunityMaterialIcons.home_outline,
color: Theme.of(context).iconTheme.color,                  ),
                  Text('الموقع الحالي'),
                ],
              ),
              value: 1,
            ),
            DropdownMenuItem(
              onTap: () async {
                LocationModel currenLocation =
                    await GeoLocationApiController.getCurrentLocation();
                if (currenLocation == null) {
                  showCustomSnackBar(
                    ' حدث خطأ أثناء تغيير موقعك',
                    'يرجى إعادة المحاولة والتأكد من صلاحيات تحديد الموقع',
                    Icon(
                      Icons.error,
                      color: Theme.of(context).errorColor,
                      size: getProportionateScreenWidth(35),
                    ),
                    context,
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapsView(
                        initialMapPosition: LatLng(
                      currenLocation.latitude,
                      currenLocation.longitude,
                    )),
                  ),
                );
                print('Clicked Location Button');
              },
              child: Row(
                children: [
                  Icon(
                    CommunityMaterialIcons.plus,
color: Theme.of(context).iconTheme.color,                  ),
                  Text('من الخريطة'),
                ],
              ),
              value: 2,
            )
          ],
          onChanged: (newValue) async {
            setState(() {
              _value = newValue;
            });
            //First we assure that the new location has been changed to the current location
            //Then we show the custom snackbar showing that the location has changed successfully
            LocationModel result =
                await GeoLocationApiController.getCurrentLocation();
            if (result == null) {
              showCustomSnackBar(
                ' حدث خطأ أثناء تغيير موقعك',
                'يرجى إعادة المحاولة والتأكد من صلاحيات تحديد الموقع',
                Icon(
                  Icons.error,
                  color: Theme.of(context).errorColor,
                  size: getProportionateScreenWidth(35),
                ),
                context,
              );
              return;
            }
            if (newValue == 1) {
              showCustomSnackBar(
                ' تم تغيير موقعك',
                'الموقع الذي تم إختياره هو: الموقع الحالي',
                Icon(
                  Icons.pin_drop,
                  color: Theme.of(context).accentColor,
                  size: getProportionateScreenWidth(35),
                ),
                context,
              );
            }
          },
        ),
      ),
    );
  }
}
