import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../controllers/delivery_boy_controller/delivery_boy_controller.dart';
import '../../models/delivery_boy_model.dart';
import '../../shared/design_components/custom_progress_indicator/custom_progress_indicator.dart';
import '../../shared/size_configuration/text_sizes.dart';
import '../wrapper_view/wrapper_view.dart';
import 'components/rate_delivery_boy_view_body.dart';

class RateDeliveryBoyView extends StatefulWidget {
  final int deliveryBoyId;
  RateDeliveryBoyView({@required this.deliveryBoyId}) : super();
  static String routeName = 'RateDeliveryBoyView';

  @override
  _RateDeliveryBoyViewState createState() => _RateDeliveryBoyViewState();
}

class _RateDeliveryBoyViewState extends State<RateDeliveryBoyView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: Theme.of(context),
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'تقييم السائق',
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontFamily: 'Almarai',
                  fontSize: TextSizes.headline6,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15,
                ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              navigator.pushReplacementNamed(WrapperView.routeName);
            },
          ),
        ),
        body: FutureBuilder<DeliveryBoyModel>(
          future:
              DeliveryBoyController.getDeliveryBoyFromId(widget.deliveryBoyId),
          builder: (context, snapshot) {
            if (snapshot.data == null || !snapshot.hasData) {
              return Center(
                child: CustomCircularProgressIndicator(),
              );
            }
            return RateDeliveryBoyViewBody(deliveryBoy: snapshot.data);
          },
        ),
      ),
    );
  }
}
