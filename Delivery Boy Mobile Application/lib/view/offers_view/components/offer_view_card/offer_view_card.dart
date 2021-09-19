import 'package:community_material_icon/community_material_icon.dart';
import 'package:delivery_boy_application/controllers/geo_location_controller.dart';
import 'package:delivery_boy_application/controllers/store_controllers/store_controller.dart';
import 'package:delivery_boy_application/models/order_model.dart';
import 'package:delivery_boy_application/models/store_model.dart';
import 'package:delivery_boy_application/shared/functional_components/current_user_components.dart';
import 'package:delivery_boy_application/view/offers_view/components/time_approximation_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../shared/size_configuration/size_config.dart';
import '../../../../shared/size_configuration/text_sizes.dart';

class OfferViewCard extends StatefulWidget {
  final OrderModel orderModel;
  OfferViewCard({@required this.orderModel}) : super();

  @override
  _OfferViewCardState createState() => _OfferViewCardState();
}

class _OfferViewCardState extends State<OfferViewCard> {
  StoreModel currentStoreForOrder;
  @override
  Widget build(BuildContext context) {
    // final _offerFoldingCellKey = GlobalKey<SimpleFoldingCellState>();

    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(15)),
      child: Center(
        child: Material(
          elevation: 1,
          child: ExpansionTile(
                      collapsedIconColor: Theme.of(context).iconTheme.color,
          iconColor:Theme.of(context).iconTheme.color ,
            title: Row(
              children: [
                Expanded(
                  child: FutureBuilder<StoreModel>(
                    future: StoreController.getStoreFromId(
                        widget.orderModel.storeId),
                    builder: (context, snapshot) {
                      if (snapshot.data == null || !snapshot.hasData) {
                        //Then still loading store details
                        return CircleAvatar(
                          radius: getProportionateScreenWidth(35),
                        );
                      }
                      currentStoreForOrder = snapshot.data;
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: getProportionateScreenWidth(35),
                            backgroundImage:
                                NetworkImage(currentStoreForOrder.logoImage),
                          ),
                          SizedBox(width: getProportionateScreenWidth(10)),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  currentStoreForOrder.storeName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontFamily: 'Almarai',
                                          fontSize: TextSizes.headline6,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.15),
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(CommunityMaterialIcons
                                          .map_marker_distance),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      FutureBuilder<double>(
                                        future: GeoLocationApiController
                                            .calculateDistanceFromCurrentLocationInKilometers(
                                          currentStoreForOrder.location,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.data == null ||
                                              !snapshot.hasData) {
                                            return Text(
                                                'جاري حساب المسافة ...',    style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                      fontFamily: 'Almarai',
                                                      fontSize: TextSizes.body1,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .overline
                                                          .color),);
                                          }
                                          return RichText(
                                            text: TextSpan(
                                              text: snapshot.data
                                                  .toStringAsFixed(2),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                      fontFamily: 'Almarai',
                                                      fontSize: TextSizes.body1,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .overline
                                                          .color),
                                              children: [
                                                TextSpan(
                                                  text: 'كم',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .overline
                                                      .copyWith(
                                                        fontFamily: 'Almarai',
                                                        fontSize:
                                                            TextSizes.caption,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenHeight(10),
                                      ),
                                      FutureBuilder<double>(
                                        future: GeoLocationApiController
                                            .calculateDistanceFromCurrentLocationInKilometers(
                                          widget.orderModel.orderLocation,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.data == null ||
                                              !snapshot.hasData) {
                                            return Text('');
                                          }
                                          return RichText(
                                            text: TextSpan(
                                              text: snapshot.data
                                                  .toStringAsFixed(2),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .copyWith(
                                                      fontFamily: 'Almarai',
                                                      fontSize: TextSizes.body1,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .overline
                                                          .color),
                                              children: [
                                                TextSpan(
                                                  text: 'كم',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .overline
                                                      .copyWith(
                                                        fontFamily: 'Almarai',
                                                        fontSize:
                                                            TextSizes.caption,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            children: [
              Column(
                children: [
                  Container(
                    height: getProportionateScreenWidth(150),
                    child: CustomScrollView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        slivers: <Widget>[
                          SliverToBoxAdapter(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildProductColumn(),
                                buildQuantityColumn(),
                                buildPriceColumn(),
                                buildTotalPriceColumn(),
                              ],
                            ),
                          )
                        ]),
                  ),
                  SizedBox(
                    height: getProportionateScreenWidth(40),
                    width: double.maxFinite,
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                      ),
                      child: Text(
                        'الموافقة على العرض',
                        style: Theme.of(context).textTheme.overline.copyWith(
                            fontFamily: 'Almarai',
                            fontSize: TextSizes.button,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.15),
                      ),
                      onPressed: () {
                        timeApproximationAlertDialog(widget.orderModel);
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildTotalPriceColumn() {
    return Expanded(
      child: Column(
        children: [
          Text(
            'الإجمالي', //TODO:functional code for total price in offers_view_body
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.subtitle1,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.15),
          ),
          SizedBox(
            height: getProportionateScreenWidth(4),
          ),

          Text(
            '25000',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.subtitle2,
                letterSpacing: 0.15),
          ),

          Divider(
            thickness: 1,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
          Text(
            '144500',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.subtitle1,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.15),
          ), //TODO: total price  in offers_view_body
        ],
      ),
    );
  }

  Expanded buildPriceColumn() {
    return Expanded(
      child: Column(
        children: [
          Text(
            'السعر', //TODO:functional code for  price one product in offers_view_body
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.subtitle1,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.15),
          ),
          SizedBox(
            height: getProportionateScreenWidth(4),
          ),
          Text(
            '5000',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.subtitle2,
                letterSpacing: 0.15),
          ),
        ],
      ),
    );
  }

  Expanded buildQuantityColumn() {
    return Expanded(
      child: Column(
        children: [
          Text(
            'الكمية', //TODO:functional code for quantity in offers_view_body
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.subtitle1,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.15),
          ),
          SizedBox(
            height: getProportionateScreenWidth(4),
          ),
          Text(
            '5',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.subtitle2,
                letterSpacing: 0.15),
          ),
        ],
      ),
    );
  }

  Expanded buildProductColumn() {
    return Expanded(
      child: Column(
        children: [
          Text(
            'الصنف', //TODO:functional code for catagory in offers_view_body
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.subtitle1,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.15),
          ),
          SizedBox(
            height: getProportionateScreenWidth(4),
          ),
          Text(
            'برغر',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.subtitle2,
                letterSpacing: 0.15),
          ),
        ],
      ),
    );
  }
}
