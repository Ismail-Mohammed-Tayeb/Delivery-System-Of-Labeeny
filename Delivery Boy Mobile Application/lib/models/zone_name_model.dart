import 'package:flutter/cupertino.dart';

class ZoneNameModel {
  int zoneNameId;
  String zoneName;
  String districtName;

  ZoneNameModel({
    @required this.zoneNameId,
    @required this.zoneName,
    @required this.districtName,
  });

  static ZoneNameModel fromMap(Map<String, dynamic> map) {
    return ZoneNameModel(
      zoneNameId: int.parse(map['zoneNameId']),
      zoneName: map['zoneName'],
      districtName: map['districtName'],
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'zoneNameId': zoneNameId.toString(),
      'zoneName': zoneName,
      'districtName': districtName,
    };
  }
}
