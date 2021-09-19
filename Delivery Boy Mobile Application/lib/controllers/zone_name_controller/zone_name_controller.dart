import 'dart:convert';

import 'package:delivery_boy_application/models/zone_name_model.dart';
import 'package:delivery_boy_application/shared/database_urls/data_base_urls.dart';
import 'package:http/http.dart';

abstract class ZoneNameController {
  static Future<ZoneNameModel> getZoneFromId(int zoneNameId) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.getZoneNameFromIdURL),
        body: {
          'zoneNameId': zoneNameId.toString(),
        },
      );
      var result = json.decode(response.body);
      if (result['code'] == '200') {
        return ZoneNameModel.fromMap(result['message']);
      }
      return null;
    } catch (e) {
      print('Exception Occured: $e');
      return null;
    }
  }
}
