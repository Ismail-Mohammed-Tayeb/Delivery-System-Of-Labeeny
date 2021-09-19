import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/cart_controller/cart_controller.dart';
import '../../../../controllers/store_related_controllers/store_controller.dart';
import '../../../../models/exported_models.dart';
import '../../../../models/order_model.dart';
import '../../../../models/store_model.dart';
import '../../../../shared/design_components/custom_progress_indicator/custom_progress_indicator.dart';
import '../../../../shared/functional_components/date_formatter.dart';
import '../../../../shared/size_configuration/size_config.dart';
import '../../../../shared/size_configuration/text_sizes.dart';

class FinishedRequestBody extends StatefulWidget {
  FinishedRequestBody({Key key}) : super(key: key);

  @override
  _FinishedRequestBodyState createState() => _FinishedRequestBodyState();
}

class _FinishedRequestBodyState extends State<FinishedRequestBody> {
  @override
  Widget build(BuildContext context) {
    //TODO: Design Theme This Method For Dark Mode !!
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: FutureBuilder<List<OrderModel>>(
        future: CartController.getAllCompleteOrders(),
        builder: (context, snapshot) {
          if (snapshot.data == null || !snapshot.hasData) {
            return Center(
              child: CustomCircularProgressIndicator(),
            );
          }
          if (snapshot.data.isEmpty) {
            return Center(
              child: Text(
                'لا توجد طلبات منتهية',
                style: Theme.of(context).textTheme.overline.copyWith(
                    color: Theme.of(context).textTheme.headline1.color,
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.subtitle1,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.15),
              ),
            );
          }
          List<OrderModel> pendingOrders = snapshot.data;

          return Padding(
            padding: EdgeInsets.only(top: getProportionateScreenHeight(10)),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: pendingOrders.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.only(bottom: getProportionateScreenHeight(10)),
                  child: buildDeliveryCard(pendingOrders[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildDeliveryCard(OrderModel orderModel) {
    // final _pendingFoldingCellKey = GlobalKey<SimpleFoldingCellState>();
    List<String> productColumnData = <String>[];
    List<String> quantityColumnData = <String>[];
    List<String> priceColumnData = <String>[];
    List<String> totalPriceColumnData = <String>[];
    List<String> toExtractDataFrom = orderModel.cartProductDetails.split(',');
    for (String item in toExtractDataFrom) {
      List<String> productString = item.split('|');
      productColumnData.add(productString[1]);
      quantityColumnData.add(productString[3]);
      priceColumnData.add(productString[2]);
      totalPriceColumnData.add(
          (double.parse(productString[2]) * int.parse(productString[3]))
              .toString());
    }
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.1),
          offset: Offset(0, 1),
          blurRadius: 2.5,
        )
      ], color: Theme.of(context).primaryColor),
      child: ExpansionTile(
        collapsedIconColor: Theme.of(context).iconTheme.color,
        iconColor: Theme.of(context).iconTheme.color,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //This Method Builds the icon to the right -- indicating the order status

            buildAppropriateIconStatus(orderModel.orderStatus),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildStoreNameText(orderModel),
                  SizedBox(
                    height: getProportionateScreenWidth(10),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          orderModel.wholeCartPrice.ceil().toString() + ' SYP',
                          style: Theme.of(context).textTheme.overline.copyWith(
                                fontFamily: 'Almarai',
                                fontSize: TextSizes.subtitle1,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.15,
                              ),
                        ),
                        VerticalDivider(
                          color: Theme.of(context).textTheme.overline.color,
                          thickness: 1,
                          indent: 1,
                        ),
                        Icon(CommunityMaterialIcons.calendar),
                        Text(
                          DateFormattrer.onlyYearMonthDay
                              .format(orderModel.deliveryDate),
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontFamily: 'Almarai',
                                fontSize: TextSizes.body1,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.15,
                              ),
                        ),
                        VerticalDivider(
                          color: Theme.of(context).textTheme.overline.color,
                          thickness: 1,
                          indent: 1,
                        ),
                        Text(
                          DateFormattrer.onlyTime
                              .format(orderModel.deliveryDate),
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontFamily: 'Almarai',
                                fontSize: TextSizes.body1,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.15,
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        children: [
          Container(
            height: getProportionateScreenWidth(150),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    children: [
                      buildProductColumn(productColumnData),
                      buildQuantityColumn(quantityColumnData),
                      buildPriceColumn(priceColumnData),
                      buildTotalPriceColumn(totalPriceColumnData),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(50)),
                  Builder(builder: (BuildContext context) {
                    double sumOfProducts = 0;
                    for (String item in totalPriceColumnData) {
                      sumOfProducts += double.parse(item);
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: getProportionateScreenWidth(8.0)),
                          child: Text(
                            'مجموع:' + sumOfProducts.toString(),
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.subtitle1,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.15,
                                    ),
                          ),
                        ),
                        VerticalDivider(),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: getProportionateScreenWidth(8.0)),
                          child: Text(
                            'أجرة التوصيل:' +
                                orderModel.deliveryFee.toStringAsFixed(2),
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.subtitle1,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.15,
                                    ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<StoreModel> buildStoreNameText(OrderModel orderModel) {
    return FutureBuilder<StoreModel>(
      future: StoreController.getStoreById(orderModel.storeId.toString()),
      builder: (context, snapshot) {
        if (snapshot.data == null || !snapshot.hasData) {
          return Text(
            '...',
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontFamily: 'Almarai',
                  fontSize: TextSizes.headline6,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15,
                ),
          );
        }
        return Text(
          snapshot.data.storeName,
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.headline6,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
              ),
        );
      },
    );
  }

  Expanded buildTotalPriceColumn(List<String> data) {
    return Expanded(
      child: Column(
        children: [
          Column(
            children: List.generate(
              data.length,
              (index) {
                if (index == 0) {
                  return Column(
                    children: [
                      Text(
                        'الإجمالي',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontFamily: 'Almarai',
                              fontSize: TextSizes.subtitle1,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.15,
                            ),
                      ),
                      SizedBox(
                        height: getProportionateScreenWidth(4),
                      ),
                      Text(
                        data[index],
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontFamily: 'Almarai',
                              fontSize: TextSizes.subtitle2,
                              letterSpacing: 0.15,
                            ),
                      ),
                    ],
                  );
                }
                return Text(
                  data[index],
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.subtitle2,
                        letterSpacing: 0.15,
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildPriceColumn(List<String> data) {
    return Expanded(
      child: Column(
        children: List.generate(data.length, (index) {
          if (index == 0) {
            return Column(
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
                  data[index],
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.subtitle2,
                        letterSpacing: 0.15,
                      ),
                ),
              ],
            );
          }
          return Text(
            data[index],
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontFamily: 'Almarai',
                  fontSize: TextSizes.subtitle2,
                  letterSpacing: 0.15,
                ),
          );
        }),
      ),
    );
  }

  Expanded buildQuantityColumn(List<String> data) {
    return Expanded(
      child: Column(
        children: List.generate(data.length, (index) {
          if (index == 0) {
            return Column(
              children: [
                Text(
                  'الكمية',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.subtitle1,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.15,
                      ),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(4),
                ),
                Text(
                  data[index],
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.subtitle2,
                        letterSpacing: 0.15,
                      ),
                ),
              ],
            );
          }
          return Text(
            data[index],
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontFamily: 'Almarai',
                  fontSize: TextSizes.subtitle2,
                  letterSpacing: 0.15,
                ),
          );
        }),
      ),
    );
  }

  Expanded buildProductColumn(List<String> data) {
    return Expanded(
      child: Column(
        children: List.generate(data.length, (index) {
          if (index == 0) {
            return Column(
              children: [
                Text(
                  'الصنف',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.subtitle1,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.15,
                      ),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(4),
                ),
                Text(
                  data[index],
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.subtitle2,
                        letterSpacing: 0.15,
                      ),
                ),
              ],
            );
          }
          return Text(
            data[index],
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontFamily: 'Almarai',
                  fontSize: TextSizes.subtitle2,
                  letterSpacing: 0.15,
                ),
          );
        }),
      ),
    );
  }

  fillData() {
    //TODO:Functional
  }

  buildAppropriateIconStatus(int status) {
    return Builder(
      builder: (BuildContext context) {
        if (status == 3) {
          return Expanded(
            child: CircleAvatar(
                backgroundColor: Colors.red[700],
                radius: 30,
                child: Icon(
                  Icons.error,
                  color: Theme.of(context).primaryColor,
                  size: getProportionateScreenWidth(40),
                )),
          );
        }
        return Expanded(
          child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 30,
              child: Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
                size: getProportionateScreenWidth(40),
              )),
        );
      },
    );
  }
}
