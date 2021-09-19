import 'dart:convert';

import 'package:http/http.dart';

import '../../model/store_related_models/store_model.dart';
import '../../model/zone_name_model.dart';
import '../../shared/database_urls/data_base_urls.dart';
import '../authentication_controllers/auth_controller.dart';

class StoreController {
  static StoreModel gbStoreModel;

  //This method shall be stored once so that the assignement to the global variable
  //will only be done once
  Future<bool> fillStoreDataFromVendorId() async {
    int vendorId = AuthenticationController.gbVendorModel.vendorId;
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.storeDataURL),
        body: {'vendorId': vendorId.toString()},
      );

      // print(response.body);
      Map result = json.decode(response.body);
      print(result);
      if (result['code'] == '200') {
        //Since this response will only contain a single result
        //no need to iterate over the result[0]
        print(result['message']);
        gbStoreModel = StoreModel.fromMap(result['message'][0]);
        return true;
      }
      return false;
    } catch (e) {
      print('Exception Occured $e');
      return false;
    }
  }

  static Future<ZoneNameModel> getZoneNameFromId() async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.getZoneNameModelFromId),
        body: {
          'zoneNameId': StoreController.gbStoreModel.zoneNameId.toString()
        },
      );
      Map result = json.decode(response.body);
      if (result['code'] == '200') {
        return ZoneNameModel.fromMap(result['message']);
      }
      return null;
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }
}
