import 'package:delivery_boy_application/shared/size_configuration/text_sizes.dart';
import 'package:flutter/material.dart';

import '../../../controllers/delivery_boy_status_controller/delivery_boy_status_controller.dart';
import '../../../controllers/orders_controllers/orders_controller.dart';
import '../../../models/order_model.dart';
import '../../../shared/size_configuration/size_config.dart';
import 'offer_view_body_with_shimmer/offer_view_card_with_shimmer.dart';
import 'offer_view_card/offer_view_card.dart';

class OfferViewBody extends StatefulWidget {
  const OfferViewBody() : super();

  @override
  _OfferViewBodyState createState() => _OfferViewBodyState();
}

class _OfferViewBodyState extends State<OfferViewBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: DeliveryBoyStatusController.getDeliveryBoyStatus(),
      builder: (context, snapshot) {
        if (snapshot.data == null || !snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(
                4,
                (index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(top: getProportionateScreenHeight(10)),
                    child: OfferViewCardWithShimmer(),
                  );
                },
              ),
            ),
          );
        }
        if (snapshot.data) {
          return Center(
            child: Text(
              'عذراً يتوجب عليك إتمام الطلبات المأخوذة أولاً',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.body1,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15,
                  ),
            ),
          );
        }
        return buildAvailableOffers();
      },
    );
  }

  Widget buildAvailableOffers() {
    return FutureBuilder<List<OrderModel>>(
      future: OrderController.getAllOrdersForDeliveryBoy(),
      builder: (context, snapshot) {
        if (snapshot.data == null || !snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(
                4,
                (index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(top: getProportionateScreenHeight(10)),
                    child: OfferViewCardWithShimmer(),
                  );
                },
              ),
            ),
          );
        }
        if (snapshot.data.isEmpty) {
          return Center(
            child: Text(
              'لا يوجد طلبات حالياً',              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.body1,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15,
                  ),
            ),
          );
        }
        // return Text('dsfds');
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return OfferViewCard(orderModel: snapshot.data[index]);
          },
        );
      },
    );
  }
}
