import 'dart:convert';

import 'package:http/http.dart';

import '../../models/vendor_model.dart';
import '../../shared/database_urls/data_base_urls.dart';

abstract class VendorController {
  static Future<VendorModel> getVendorFromId(int vendorId) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.getVendorModelFromId),
        body: {'vendorId': vendorId.toString()},
      );
      Map result = json.decode(response.body);
      if (result['code'] == '200') {
        VendorModel toReturn = VendorModel.fromMap(result['message']);
        return toReturn;
      }
      return null;
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }
}
