import 'dart:convert';

import 'package:http/http.dart';

import '../model/requests_models/sub_category_request_model.dart';
import '../shared/database_urls/data_base_urls.dart';
import 'authentication_controllers/auth_controller.dart';

class NotificationController {
  //TODO: Continue Implementing Notifications
  getAllNotifications() async {
    await getSubCategoryRecommendationRequestNotificaction();
    await getProductRequestNotificaction();
  }

  Future<List<SubCategoryRequestModel>>
      getSubCategoryRecommendationRequestNotificaction() async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.readSubCategoryRequestsURL),
        body: {
          'vendorId':
              AuthenticationController.gbVendorModel.vendorId.toString(),
        },
      );

      Map result = json.decode(response.body);
      print('Message Is : ${result['message']}');
      if (result['code'] == '200') {
        List<SubCategoryRequestModel> allRecommendations =
            <SubCategoryRequestModel>[];
        for (Map<String, dynamic> item in result['message']) {
          allRecommendations.add(SubCategoryRequestModel.fromMap(item));
        }
        return allRecommendations;
      } else {
        return [];
      }
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }

  getProductRequestNotificaction() async {}
}
