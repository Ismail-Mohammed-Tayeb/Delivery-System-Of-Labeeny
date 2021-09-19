import 'package:delivery_boy_application/controllers/orders_controllers/orders_controller.dart';
import 'package:delivery_boy_application/models/order_model.dart';
import 'package:delivery_boy_application/shared/design_components/custom_toast/customSnackBar.dart';
import 'package:delivery_boy_application/shared/size_configuration/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRContainer extends StatefulWidget {
  final OrderModel orderModel;
  QRContainer({@required this.orderModel}) : super();

  @override
  _QRContainerState createState() => _QRContainerState();
}

class _QRContainerState extends State<QRContainer> {
  int approximateMinutes;
  var dialodRadius = BorderRadius.only(
    topRight: Radius.circular(
      getProportionateScreenWidth(20),
    ),
    topLeft: Radius.circular(
      getProportionateScreenWidth(20),
    ),
  );
  var dialogShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    spreadRadius: 5,
    blurRadius: 7,
    offset: Offset(0, 3),
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: (SizeConfiguration.screenWidth * .08),
          right: SizeConfiguration.screenWidth * .08,
          top: (SizeConfiguration.screenHeight * 0.2),
          bottom: (SizeConfiguration.screenHeight * 0.2)),
      child: Container(
        width: SizeConfiguration.screenWidth * .8,
        height: SizeConfiguration.screenHeight * 0.3,
        decoration: BoxDecoration(
            boxShadow: [dialogShadow],
            color: Theme.of(context).primaryColor,
            borderRadius: dialodRadius,
            border: Border.all(color: Theme.of(context).accentColor)),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                  child: Text(
                'هذا الكود يتم  مسحه من قبل الزبون',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
              Material(
                child: QrImage(
                  size: getProportionateScreenWidth(280),
                  data: (widget.orderModel.orderQr +
                      "," +
                      widget.orderModel.orderId.toString()),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

qrAlertDialog(OrderModel orderModel) {
  Get.dialog(
    Container(
        width: 200, height: 200, child: QRContainer(orderModel: orderModel)),
    barrierDismissible: false,
  );
}
