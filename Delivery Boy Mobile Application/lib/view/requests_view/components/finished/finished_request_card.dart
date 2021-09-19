import 'package:delivery_boy_application/controllers/store_controllers/store_controller.dart';
import 'package:delivery_boy_application/models/order_model.dart';
import 'package:delivery_boy_application/models/store_model.dart';
import 'package:flutter/material.dart';

import '../../../../shared/size_configuration/size_config.dart';
import '../../../../shared/size_configuration/text_sizes.dart';

class FinishedRequestCard extends StatefulWidget {
  final OrderModel orderModel;
  FinishedRequestCard({@required this.orderModel}) : super();
  @override
  _FinishedRequestCardState createState() => _FinishedRequestCardState();
}

class _FinishedRequestCardState extends State<FinishedRequestCard> {
  double containerHeight = 100;
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                      SizedBox(height: getProportionateScreenHeight(5)),
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
                          FutureBuilder<StoreModel>(
                            future: StoreController.getStoreFromId(
                                widget.orderModel.storeId),
                            builder: (context, snapshot) {
                              if (snapshot.data == null || !snapshot.hasData) {
                                //Then still loading store details
                                return Text('Loading');
                              }
                              return Text(
                                snapshot.data.storeName,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.subtitle1,
                                      letterSpacing: 0.15,
                                    ),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            ' بتاريخ:',
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
                            widget.orderModel.deliveryDate
                                .toString()
                                .substring(0, 10),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.subtitle1,
                                    letterSpacing: 0.15),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            ' باجرة توصيل: ',
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
                            widget.orderModel.deliveryFee.toStringAsFixed(2) +
                                '  ل.س',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.subtitle1,
                                    letterSpacing: 0.15),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(5)),
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildTotalPriceColumn() {
    return Expanded(
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
            '144500',
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
    buildProductColumn();
    buildQuantityColumn();
    buildPriceColumn();
    buildTotalPriceColumn(); //TODO:Functional
  }
}
