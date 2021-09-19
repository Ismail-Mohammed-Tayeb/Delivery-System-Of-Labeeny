import 'package:flutter/cupertino.dart';

class DistrictModel {
  int districtId;
  double pricePerKm;
  String districtName;

  DistrictModel({
    @required this.districtId,
    @required this.pricePerKm,
    @required this.districtName,
  });

  static DistrictModel fromMap(Map<String, dynamic> map) {
    return DistrictModel(
      districtId: int.parse(map['districtId']),
      pricePerKm: double.parse(map['pricePerKm']),
      districtName: map['districtName'],
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'districtId': districtId.toString(),
      'pricePerKm': pricePerKm.toString(),
      'districtName': districtName,
    };
  }
}
