import 'package:flutter/foundation.dart';

import '../shared/database_urls/data_base_urls.dart';
import 'exported_models.dart';

// geolocator:
// http: null
// image_picker: null
// uuid: null
class CustomerModel extends UserModel {
  LocationModel location;
  CustomerModel({
    @required int userId,
    @required String phoneNumber,
    @required String password,
    @required String name,
    @required String portraitImageURL,
    @required int userType,
    @required this.location,
  }) : super(
          userId: userId,
          phoneNumber: phoneNumber,
          password: password,
          name: name,
          portraitImageURL: portraitImageURL,
          userType: userType,
        );

  static CustomerModel fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      userId: int.parse(map['userId'].toString()),
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      name: map['name'],
      portraitImageURL: map['portraitImageURL'] != null
          ? DataBaseEndPoints.customerUploadImagePath + map['portraitImageURL']
          : 'null',
      userType: int.parse(map['userId'].toString()) ?? null,
      location: LocationModel.fromString(map['location']),
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      // 'userId': this.userId,
      'phoneNumber': this.phoneNumber,
      'password': this.password,
      'name': this.name,
      'portraitImageURL':
          this.portraitImageURL == 'null' ? 'null' : this.portraitImageURL,
      'userType': this.userType.toString(),
      'location': this.location.toString(),
    };
  }
}
