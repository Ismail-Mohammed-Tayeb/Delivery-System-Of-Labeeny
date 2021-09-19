import 'dart:convert';

import 'package:http/http.dart';

import '../../shared/database_urls/data_base_urls.dart';
import '../../shared/functional_components/current_user_components.dart';

abstract class OrderController {
  //This method returns an integer so that the next screen will take this parameter as the delivery
  //boy id and pass it later to be used for the rating proccess
  static Future<int> setOrderAsDelivered(String orderQr, int orderId) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.setOrderAsDeliveredURL),
        body: {
          'orderId': orderId.toString(),
          'orderQr': orderQr,
          'customerId': gbCustomerModel.userId.toString(),
        },
      );
      Map result = json.decode(response.body);
      print(result['code']);
      print(result['message']);
      if (result['code'] == '200') {
        return int.parse(result['message']);
      }
      //Minus one means that the proccess falied and the result is thus -1 since no id has the value index
      //Starting with -1
      return -1;
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }
}
