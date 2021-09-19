import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/exported_models.dart';
import '../../shared/database_urls/data_base_urls.dart';
import '../../shared/functional_components/current_user_components.dart';
import '../authentication_controllers/auth_controller.dart';

class CategorySearchController {
  Future<List<StoreModel>> searchStoresByName(String storeName) async {
    try {
      http.Response response = await http.post(
        Uri.parse(DataBaseEndPoints.searchStoresByName),
        body: {'txtSearch': storeName},
        headers: AuthenticationController().getAuthenticationHeader(
          gbCustomerModel.phoneNumber,
          gbCustomerModel.password,
        ),
      );

      Map result = json.decode(response.body);
      if (result['code'] == '200') {
        List<StoreModel> allStores = <StoreModel>[];
        for (Map<String, dynamic> item in result['message']) {
          allStores.add(StoreModel.fromMap(item));
        }
        return allStores;
      } else {
        return [];
      }
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }
}
