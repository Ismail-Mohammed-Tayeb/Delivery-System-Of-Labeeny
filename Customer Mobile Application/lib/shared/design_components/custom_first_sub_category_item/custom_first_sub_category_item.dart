import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import '../../../controllers/location_controllers/geo_location_controller.dart';
import '../../../controllers/zone_name_controllers/zone_name_controller.dart';
import '../../../models/exported_models.dart';
import '../../../models/zone_name_model.dart';
import '../../../view/store_product_view/store_product_view.dart';
import '../../functional_components/current_user_components.dart';
import '../../size_configuration/size_config.dart';
import '../../size_configuration/text_sizes.dart';

class CustomFirstSubCategoryItem extends StatefulWidget {
  final StoreModel storeModel;
  CustomFirstSubCategoryItem({this.storeModel}) : super();

  @override
  _CustomFirstSubCategoryItemState createState() =>
      _CustomFirstSubCategoryItemState();
}

class _CustomFirstSubCategoryItemState
    extends State<CustomFirstSubCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomRight,
              width: getProportionateScreenWidth(375),
              height: getProportionateScreenHeight(400),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        offset: Offset(0, 1),
                        blurRadius: 2.5),
                  ],
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(25))),
              child: Container(
                width: getProportionateScreenWidth(375),
                height: getProportionateScreenHeight(100),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(
                        getProportionateScreenWidth(25),
                      ),
                      bottomStart: Radius.circular(
                        getProportionateScreenWidth(25),
                      ),
                    )),
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(8.0)),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              // color: Colors.red,
                              alignment: Alignment.topRight,

                              child: Row(
                                textDirection: TextDirection.rtl,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.storeModel.storeName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                            fontFamily: 'Almarai',
                                            fontSize: TextSizes.body1,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.15),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  SizedBox(
                                    width: getProportionateScreenWidth(8),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        getProportionateScreenWidth(26)),
                                    child: Container(
                                      height: getProportionateScreenWidth(30),
                                      width: getProportionateScreenWidth(30),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              widget.storeModel.logoImage,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AutoSizeText(
                              widget.storeModel.quote,
                              textDirection: TextDirection.rtl,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.subtitle1,
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.15),
                              maxLines: 1,
                              minFontSize: 14,
                              stepGranularity: 14,
                              wrapWords: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                            buildLocationNameText(),
                          ],
                        ),
                      ),
                      Column(
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            textDirection: TextDirection.rtl,
                            children: [
                              //TODO: Make Logo Position Correct

                              Icon(
                                FontAwesomeIcons.star,
                                size: getProportionateScreenWidth(15),
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(5),
                              ),
                              Text(
                                widget.storeModel.rating.toString(),
                                textDirection: TextDirection.rtl,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.subtitle1,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0.15,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            textDirection: TextDirection.rtl,
                            children: [
                              Icon(
                                FontAwesomeIcons.truck,
                                size: getProportionateScreenWidth(15),
                                textDirection: TextDirection.rtl,
                              ),
                              SizedBox(width: getProportionateScreenWidth(8)),
                              Text(
                                GeoLocationApiController
                                            .calculateDistanceInKilometers(
                                                gbCustomerModel.location,
                                                widget.storeModel.location)
                                        .toStringAsFixed(2) +
                                    ' كم',
                                textDirection: TextDirection.rtl,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontFamily: 'Almarai',
                                        fontSize: TextSizes.subtitle1,
                                        fontWeight: FontWeight.normal,
                                        letterSpacing: 0.15),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: getProportionateScreenWidth(375),
              height: getProportionateScreenHeight(300),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.2),
                        offset: Offset(0, 1),
                        blurRadius: 2.5),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.storeModel.bannerImage,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(
                      getProportionateScreenWidth(25),
                    ),
                    topStart: Radius.circular(
                      getProportionateScreenWidth(25),
                    ),
                  )),
            ),
            Positioned(
              child: SizedBox(
                width: getProportionateScreenWidth(375),
                height: getProportionateScreenHeight(400),
                child: Material(
                  type: MaterialType.transparency,
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(25)),
                  child: InkWell(
                      splashColor:
                          Theme.of(context).accentColor.withOpacity(.08),
                      highlightColor:
                          Theme.of(context).accentColor.withOpacity(.05),
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(25),
                      ),
                      onTap: () {
                        Get.toNamed(
                          StoreProductView.routeName,
                          arguments: widget.storeModel,
                        ); //TODO:NOTE  implicit send catagoryName to another page},\
                        //TODO:send  Name subCategory in arguments
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder<ZoneNameModel> buildLocationNameText() {
    return FutureBuilder<ZoneNameModel>(
      future:
          ZoneNameController.getZoneNameFromId(widget.storeModel.zoneNameId),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return AutoSizeText(
            'الموقع:',
            textDirection: TextDirection.rtl,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.subtitle1,
                fontWeight: FontWeight.w100,
                letterSpacing: 0.15),
            maxLines: 1,
            minFontSize: 14,
            stepGranularity: 14,
            wrapWords: false,
            overflow: TextOverflow.ellipsis,
          );
        }
        String storeZoneName = 'الموقع: ' +
            snapshot.data.districtName +
            '-' +
            snapshot.data.zoneName;
        return AutoSizeText(
          storeZoneName,
          textDirection: TextDirection.rtl,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontFamily: 'Almarai',
              fontSize: TextSizes.subtitle1,
              fontWeight: FontWeight.w100,
              letterSpacing: 0.15),
          maxLines: 1,
          minFontSize: 14,
          stepGranularity: 14,
          wrapWords: false,
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}
