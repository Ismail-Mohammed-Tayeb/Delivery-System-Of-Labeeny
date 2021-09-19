import 'dart:convert';

import 'package:http/http.dart';

import '../../models/order_model.dart';
import '../../shared/database_urls/data_base_urls.dart';
import '../../shared/functional_components/current_user_components.dart';

abstract class OrderController {
  static Future<List<OrderModel>> getAllOrdersForDeliveryBoy() async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.availableOrdersURL),
        body: {
          'zoneNameId': gbDeliveryBoyModel.zoneNameId.toString(),
          'vehicleTypeId': gbDeliveryBoyModel.vehicleTypeId.toString(),
        },
      );
      var result = json.decode(response.body);
      if (result['code'] == '200') {
        List<OrderModel> orderModels = <OrderModel>[];
        for (Map<String, dynamic> item in result['message']) {
          orderModels.add(OrderModel.fromMap(item));
        }
        return orderModels;
      }
      return null;
    } catch (e) {
      print('Exception Occured: $e');
      return null;
    }
  }

  static Future<bool> takeOrderForCurrentDeliveryBoy(
      int orderId, int approximateTimeInMinutes) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.takeOrderByDeliveryBoyURL),
        body: {
          'deliveryBoyId': gbDeliveryBoyModel.userId.toString(),
          'orderId': orderId.toString(),
          'approximateTimeInMinutes': approximateTimeInMinutes.toString(),
        },
      );
      var result = json.decode(response.body);
      if (result['code'] == '200') {
        return true;
      }
      return false;
    } catch (e) {
      print('Exception Occured While Taking Order: $e');
      //Handle when null is returened as an exception
      return null;
    }
  }

  static Future<List<OrderModel>> getAllOrdersForDeliveryBoyAndByOrderStatus(
      int orderStatus) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.getOrderByDeliveryBoyAndOrderStatusURL),
        body: {
          'deliveryBoyId': gbDeliveryBoyModel.userId.toString(),
          'orderStatus': orderStatus.toString(),
        },
      );
      var result = json.decode(response.body);
      if (result['code'] == '200') {
        List<OrderModel> orderModels = <OrderModel>[];
        for (Map<String, dynamic> item in result['message']) {
          orderModels.add(OrderModel.fromMap(item));
        }
        return orderModels;
      }
      return null;
    } catch (e) {
      print('Exception Occured While Getting Order List For DeliveryBoy\n: $e');
      return null;
    }
  }
}
