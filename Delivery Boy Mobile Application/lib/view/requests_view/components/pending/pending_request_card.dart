import 'package:community_material_icon/community_material_icon.dart';
import 'package:delivery_boy_application/controllers/store_controllers/store_controller.dart';
import 'package:delivery_boy_application/models/order_model.dart';
import 'package:delivery_boy_application/models/store_model.dart';
import 'package:delivery_boy_application/shared/design_components/google_maps_view/maps_view.dart';
import 'package:delivery_boy_application/view/requests_view/components/qr_related_components/qr_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../shared/size_configuration/size_config.dart';
import '../../../../shared/size_configuration/text_sizes.dart';
import 'dart:math' as math;

class PendingRequestCard extends StatefulWidget {
  final OrderModel orderModel;
  PendingRequestCard({@required this.orderModel}) : super();

  @override
  _PendingRequestCardState createState() => _PendingRequestCardState();
}

class _PendingRequestCardState extends State<PendingRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 1,
        child: ExpansionTile(
                    collapsedIconColor: Theme.of(context).iconTheme.color,
          iconColor:Theme.of(context).iconTheme.color ,
          title: Container(
            height: 100,
            child: Row(
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
                      return CircleAvatar(
                        radius: getProportionateScreenWidth(35),
                        backgroundImage: NetworkImage(snapshot.data.logoImage),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(10),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            'من:',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.body1,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.15),
                          ),
                          Text(
                            ' ماكدونالدز', //TODO:store name in requist pindding body
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.body2,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.15),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            ' إلى:',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.body1,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.15),
                          ),
                          Text(
                            ' محمد عبد العظيم عبد الله', //TODO:customer name in requist pindding body
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.body2,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.15),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'رقم الزبون:',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.body1,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.15),
                          ),
                          Text(
                            ' 0999888111', //TODO:customer number in requist pindding body
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.body2,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.15),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(240),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(math.pi),
                                  child: Icon(
                                    CommunityMaterialIcons.truck_fast_outline,
                                  ),
                                ),
                                Icon(Icons.horizontal_rule),
                                RichText(
                                  text: TextSpan(
                                      text:
                                          '2500', //TODO:functional code for distance requist pindding body
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                              fontFamily: 'Almarai',
                                              fontSize: TextSizes.body2,
                                              fontWeight: FontWeight.bold,
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
                                                  fontSize: TextSizes.caption,
                                                  fontWeight: FontWeight.bold,
                                                ))
                                      ]),
                                ),
                                Icon(Icons.west),
                                Icon(
                                  CommunityMaterialIcons.store_outline,
                                ),

                                Icon(Icons.horizontal_rule),
                                RichText(
                                  text: TextSpan(
                                      text:
                                          '2500', //TODO:functional code for distance requist pindding body
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                              fontFamily: 'Almarai',
                                              fontSize: TextSizes.body2,
                                              fontWeight: FontWeight.bold,
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
                                                  fontSize: TextSizes.caption,
                                                  fontWeight: FontWeight.bold,
                                                ))
                                      ]),
                                ),
                                Icon(Icons.west),

                                Icon(
                                  CommunityMaterialIcons.account_outline,
                                ), //TODO:time in requist pindding body
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: getProportionateScreenWidth(8.0),
                      right: getProportionateScreenWidth(22)),
                ),
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
                Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Text(
                        'الخرائط',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontFamily: 'Almarai',
                            fontSize: TextSizes.subtitle1,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.15),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(),
                              ),
                              child: Text(
                                'من موقعي للمورد',
                                style: Theme.of(context)
                                    .textTheme
                                    .overline
                                    .copyWith(
                                        fontFamily: 'Almarai',
                                        fontSize: TextSizes.button,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.15),
                              ),
                              onPressed: openMapDrawRouteToVendor,
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(),
                              ),
                              child: Text(
                                'من المورد للزبون',
                                style: Theme.of(context)
                                    .textTheme
                                    .overline
                                    .copyWith(
                                        fontFamily: 'Almarai',
                                        fontSize: TextSizes.button,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.15),
                              ),
                              onPressed: openMapDrawRouteToCustomer,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                        ),
                        child: Text(
                          'عرض الكود ليقوم الزبون بمسحه',
                          style: Theme.of(context).textTheme.overline.copyWith(
                              fontFamily: 'Almarai',
                              fontSize: TextSizes.button,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.15),
                        ),
                        onPressed: () {
                          qrAlertDialog(widget.orderModel);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildTotalPriceColumn() {
    return Expanded(
      // flex: 2,
      child: Column(
        children: [
          Text(
            'الإجمالي',
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
            '25000',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.subtitle1,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.15),
          ), //TODO: total price
        ],
      ),
    );
  }

  Expanded buildPriceColumn() {
    return Expanded(
      // flex: 2,
      child: Column(
        children: [
          Text(
            'السعر',
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
      // flex: 1,
      child: Column(
        children: [
          Text(
            'الكمية',
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
      // flex: 3,
      child: Column(
        children: [
          Text(
            'الصنف',
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

  fillData() {
    //TODO:Functional
  }
  void openMapDrawRouteToCustomer() async {
    StoreModel currentStore =
        await StoreController.getStoreFromId(widget.orderModel.storeId);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MapCreatorWrapper(
          fromCurrentLocation: false,
          sourceLocation: LatLng(
              currentStore.location.latitude, currentStore.location.longitude),
          destLocation: LatLng(widget.orderModel.orderLocation.latitude,
              widget.orderModel.orderLocation.longitude));
    }));
  }

  void openMapDrawRouteToVendor() async {
    StoreModel currentStore =
        await StoreController.getStoreFromId(widget.orderModel.storeId);
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MapCreatorWrapper(
          fromCurrentLocation: true,
          sourceLocation: null,
          destLocation: LatLng(
              currentStore.location.latitude, currentStore.location.longitude));
    }));
  }
}

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
