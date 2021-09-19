import 'package:flutter/foundation.dart';

import '../../shared/database_urls/data_base_urls.dart';
import 'user_model.dart';

// geolocator:
// http: null
// image_picker: null
// uuid: null
class VendorModel extends UserModel {
  bool isBanned;
  int vendorId;
  VendorModel({
    @required int userId,
    @required String phoneNumber,
    @required String password,
    @required String name,
    @required String portraitImageURL,
    @required int userType,
    @required this.isBanned,
    @required this.vendorId,
  }) : super(
          userId: userId,
          phoneNumber: phoneNumber,
          password: password,
          name: name,
          portraitImageURL: portraitImageURL,
          userType: userType,
        );

  static VendorModel fromMap(Map<String, dynamic> map) {
    return VendorModel(
      userId: int.parse(map['userId'].toString()),
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      name: map['name'],
      portraitImageURL: map['portraitImageURL'] == null
          ? 'null'
          : DataBaseEndPoints.vendorImageURL + map['portraitImageURL'],
      userType: int.parse(map['userId'].toString()) ?? null,
      //Checking if the entered value is true or false by checking this condition
      isBanned: int.parse(map['isBanned']) == 1 ? true : false,
      vendorId: int.parse(map['id']),
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'userId': this.userId.toString(),
      'phoneNumber': this.phoneNumber,
      'password': this.password,
      'name': this.name,
      'portraitImageURL':
          this.portraitImageURL == 'null' ? 'null' : this.portraitImageURL,
      'userType': this.userType.toString(),
      'isBanned': this.isBanned ? '1' : '0',
      'id': this.vendorId.toString(),
    };
  }
}
