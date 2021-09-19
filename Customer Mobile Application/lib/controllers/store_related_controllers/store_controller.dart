import 'dart:convert';

import 'package:http/http.dart';

import '../../models/exported_models.dart';
import '../../shared/database_urls/data_base_urls.dart';

class StoreController {
  static Future<StoreModel> getStoreById(String storeId) async {
    try {
      print(DataBaseEndPoints.storeDetailsFromIdURL);
      Response response = await post(
        Uri.parse(DataBaseEndPoints.storeDetailsFromIdURL),
        body: {'storeId': storeId},
      );
      Map result = json.decode(response.body);
      if (result['code'] == '200') {
        StoreModel toReturn = StoreModel.fromMap(result['message']);
        return toReturn;
      } else {
        return null;
      }
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }
}
