import 'dart:convert';

import 'package:http/http.dart';

import '../../models/district_model.dart';
import '../../models/zone_name_model.dart';
import '../../shared/database_urls/data_base_urls.dart';

class ZoneNameController {
  static Future<ZoneNameModel> getZoneNameFromId(int zoneNameId) async {
    try {
      Response response = await post(
          Uri.parse(DataBaseEndPoints.zoneNameFromIdURL),
          body: {'zoneNameId': zoneNameId.toString()});
      Map result = json.decode(response.body);
      if (result['code'] == '200') {
        ZoneNameModel toReturn = ZoneNameModel.fromMap(result['message'][0]);
        return toReturn;
      } else {
        return null;
      }
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }

  static Future<DistrictModel> getDistrictModelFromZoneNameId(
      int zoneName) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.getDistrictFromZoneNameIdURL),
        body: {'zoneNameId': zoneName.toString()},
      );
      Map result = json.decode(response.body);
      if (result['code'] == '200') {
        DistrictModel toReturn = DistrictModel.fromMap(result['message']);
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
