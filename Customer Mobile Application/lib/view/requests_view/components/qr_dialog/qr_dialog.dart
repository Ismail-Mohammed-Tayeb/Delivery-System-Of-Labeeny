import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/order_controllers/order_controller.dart';
import '../../../../shared/design_components/custom_elevated_button/custom_elevated_button.dart';
import '../../../../shared/size_configuration/size_config.dart';
import '../../../../shared/size_configuration/text_sizes.dart';
import '../../../rate_delivery_boy_view/rate_delivery_boy_view.dart';

class QRContainer extends StatefulWidget {
  QRContainer() : super();

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
    bottomLeft: Radius.circular(
      getProportionateScreenWidth(20),
    ),
    bottomRight: Radius.circular(
      getProportionateScreenWidth(20),
    ),
  );
  var dialogShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    spreadRadius: 5,
    blurRadius: 7,
    offset: Offset(0, 3),
  );
  String qrValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: (SizeConfiguration.screenWidth * .08),
        right: SizeConfiguration.screenWidth * .08,
        top: (SizeConfiguration.screenHeight * 0.2),
        bottom: (SizeConfiguration.screenHeight * 0.2),
      ),
      child: Container(
        width: SizeConfiguration.screenWidth * .8,
        height: SizeConfiguration.screenHeight * 0.3,
        decoration: BoxDecoration(
          boxShadow: [dialogShadow],
          color: Theme.of(context).primaryColor,
          borderRadius: dialodRadius,
          border: Border.all(color: Theme.of(context).accentColor),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                child: Text(
                  'إمسح الكود لتأكيد إستلام الطلب',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.button,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Column(
                children: [
                  CustomElevatedButton(
                    child: Text(
                      'إمسح',
                      style: Theme.of(context).textTheme.button.copyWith(
                            fontFamily: 'Almarai',
                            fontSize: TextSizes.button,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    onPressed: _scanQrCode,
                    buttonheight: 40,
                    buttonWidth: 250,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  CustomElevatedButton(
                    child: Text(
                      'إلغاء',
                      style: Theme.of(context).textTheme.button.copyWith(
                            fontFamily: 'Almarai',
                            fontSize: TextSizes.button,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    onPressed: () {
                      navigator.pop(
                          context); //TODO: Functional code for edit profile Data
                    },
                    buttonheight: 40,
                    buttonWidth: 250,
                  )
                ],
              ),
              Material(
                child: Text(
                  qrValue == null
                      ? ''
                      : (qrValue.isEmpty
                          ? 'لم يتم مسح الكود !!'
                          : 'يتم نقلك الى واجهة تقييم السائق'),
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.button,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _scanQrCode() async {
    var result = await BarcodeScanner.scan();
    setState(() {
      qrValue = result.rawContent;
    });
    if (result.rawContent.isEmpty) return;
    int settingResultWithDeliveryBoyIdRes =
        await OrderController.setOrderAsDelivered(
            qrValue.split(',')[0], int.parse(qrValue.split(',')[1]));
    if (settingResultWithDeliveryBoyIdRes != null &&
        settingResultWithDeliveryBoyIdRes > -1) {
      print(
        'Request Set To: ' + settingResultWithDeliveryBoyIdRes.toString(),
      );
      //Then the request is done and true so the delivery boy id is now in hand and can be
      //passed to the next screen where the delivery boy service is being rated
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RateDeliveryBoyView(
            deliveryBoyId: settingResultWithDeliveryBoyIdRes,
          ),
        ),
      );
      return;
    }
    //TODO: Design Show Error Here Saying That the method Failed Please Retry
    print('Error Encountered Please Retry');
  }
}

qrAlertDialog() {
  Get.dialog(
    Container(
      width: 200,
      height: 200,
      child: QRContainer(),
    ),
    barrierDismissible: false,
  );
}
