import 'package:delivery_boy_application/controllers/orders_controllers/orders_controller.dart';
import 'package:delivery_boy_application/models/order_model.dart';
import 'package:delivery_boy_application/shared/size_configuration/size_config.dart';
import 'package:delivery_boy_application/shared/size_configuration/text_sizes.dart';
import 'package:delivery_boy_application/view/requests_view/components/finished/finished_request_card.dart';
import 'package:flutter/material.dart';

import 'finished_request_card_with_shimmer.dart';

class FinishedRequestBody extends StatefulWidget {
  FinishedRequestBody() : super();

  @override
  _FinishedRequestBodyState createState() => _FinishedRequestBodyState();
}

class _FinishedRequestBodyState extends State<FinishedRequestBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderModel>>(
      future: OrderController.getAllOrdersForDeliveryBoyAndByOrderStatus(2),
      builder: (context, snapshot) {
        if (snapshot.data == null || !snapshot.hasData) {
          return Column(
            children: List.generate(3, (index) {
              return Padding(
                padding: EdgeInsets.only(top: getProportionateScreenHeight(10)),
                child: FinishedRequestCardWithShimmer(),
              );
            }),
          );
        }
        if (snapshot.data.length == 0) {
          return Text(
            "No History",
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.body1,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.overline.color),
          );
        }
        return Column(
          children: List.generate(snapshot.data.length, (index) {
            return FinishedRequestCard(orderModel: snapshot.data[index]);
          }),
        );
      },
    );
  }
}
