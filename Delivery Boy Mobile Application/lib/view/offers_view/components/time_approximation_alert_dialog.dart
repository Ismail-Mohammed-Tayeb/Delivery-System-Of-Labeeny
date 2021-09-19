import 'package:delivery_boy_application/controllers/orders_controllers/orders_controller.dart';
import 'package:delivery_boy_application/models/order_model.dart';
import 'package:delivery_boy_application/shared/design_components/custom_toast/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/size_configuration/size_config.dart';

class TimeApproximationContainer extends StatefulWidget {
  final OrderModel orderModel;
  TimeApproximationContainer({@required this.orderModel}) : super();

  @override
  _TimeApproximationContainerState createState() =>
      _TimeApproximationContainerState();
}

class _TimeApproximationContainerState
    extends State<TimeApproximationContainer> {
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
          left: (SizeConfiguration.screenWidth * .1),
          right: SizeConfiguration.screenWidth * .1,
          top: (SizeConfiguration.screenHeight * 0.3),
          bottom: (SizeConfiguration.screenHeight * 0.3)),
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
                'أدخل الوقت التقديري لوصول الطلب',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
              Material(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10)),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (txt) {
                      if (txt.trim().length == 0) {
                        approximateMinutes = null;
                        return;
                      }
                      if (int.parse(txt) > 0) {
                        approximateMinutes = int.parse(txt);
                        return;
                      }
                      approximateMinutes = null;
                    },
                  ),
                ),
              ),
              Material(
                child: Text(
                  'ملاحظة: الوقت المدخل بالدقائق ولا يمكن التراجع عن هذه العملية',
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: acceptOrderClick, child: Text('Accept')),
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

  void acceptOrderClick() async {
    if (approximateMinutes == null) {
      showCustomSnackBar(
          'Error', 'Input Error Try Again', Icon(Icons.error), context);
      return;
    }
    bool takeOrderReult = await OrderController.takeOrderForCurrentDeliveryBoy(
        widget.orderModel.orderId, approximateMinutes);
    if (takeOrderReult != null && takeOrderReult) {
      Navigator.pop(context);
      showCustomSnackBar(
          'Done', 'Order Taken Successfully', Icon(Icons.check), context);
      return;
    }

    ///Taken At The Same Time An Error is Thrown
    showCustomSnackBar('Error', 'Exception Occured Try Again Later',
        Icon(Icons.error), context);
  }
}

timeApproximationAlertDialog(OrderModel orderModel) {
  Get.dialog(
    Container(
        width: 200,
        height: 200,
        child: TimeApproximationContainer(orderModel: orderModel)),
    barrierDismissible: false,
  );
}
