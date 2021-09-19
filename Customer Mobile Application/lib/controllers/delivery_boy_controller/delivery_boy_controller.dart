import 'dart:convert';

import 'package:http/http.dart';

import '../../models/delivery_boy_model.dart';
import '../../shared/database_urls/data_base_urls.dart';

abstract class DeliveryBoyController {
  static Future<DeliveryBoyModel> getDeliveryBoyFromId(
      int deliveryBoyId) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.getDeliveryBoyForRateFromId),
        body: {
          'userId': deliveryBoyId.toString(),
        },
      );
      Map result = json.decode(response.body);
      print(result['message']);
      if (result['code'] == '200') {
        return DeliveryBoyModel.fromMap(result['message']);
      }
      return null;
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }

  static Future<bool> rateDeliveryBoy(
      int deliveryBoyId, double newRating, int newNumberOfPeopleRating) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.rateDeliveryBoyById),
        body: {
          "userId": deliveryBoyId.toString(),
          "rating": newRating.toString(),
          "numberOfPeopleRating": newNumberOfPeopleRating.toString(),
        },
      );
      Map result = json.decode(response.body);
      print(result['message']);
      if (result['code'] == '200') {
        return true;
      }
      return false;
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }
}
