import 'dart:convert';

import 'package:http/http.dart';

import '../../shared/database_urls/data_base_urls.dart';
import '../../shared/functional_components/current_user_components.dart';

class DeliveryBoyStatusController {
  ///This Method Returns `True` if the delivery boy is busy
  ///
  ///`False` otherwise
  static Future<bool> getDeliveryBoyStatus() async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.deliveryBoyStatusURL),
        body: {'deliveryBoyId': '${gbDeliveryBoyModel.deliveryBoyId}'},
      );
      if (json.decode(response.body)['code'] == '200') {
        if (int.parse(json.decode(response.body)['message']) == 1) {
          return true;
        }
        return false;
      }
      return null;
    } catch (e) {
      print('Exception Occured: ${e.message}');
      return null;
    }
  }

  static Future<bool> updateDeliveryBoyStatus() async {}
}
