import 'package:flutter/foundation.dart';

import '../shared/database_urls/data_base_urls.dart';
import 'user_model.dart';

class DeliveryBoyModel extends UserModel {
  int deliveryBoyId;
  double rating;
  int numberOfPeopleRating;
  int zoneNameId;
  int vehicleTypeId;
  String vehiclePlate;
  bool isBusy;

  ///Depending On 24 Hours Format Filled From View
  Duration startHour;

  ///Depending On 24 Hours Format Filled From View
  Duration endHour;

  DeliveryBoyModel({
    @required int userId,
    @required String phoneNumber,
    @required String password,
    @required String name,
    @required String portraitImageURL,
    @required int userType,
    //UserModel Parameters End Here
    @required this.deliveryBoyId,
    @required this.rating,
    @required this.numberOfPeopleRating,
    @required this.zoneNameId,
    @required this.vehicleTypeId,
    this.vehiclePlate,
    @required this.isBusy,
    @required this.startHour,
    @required this.endHour,
  }) : super(
          userId: userId,
          phoneNumber: phoneNumber,
          password: password,
          name: name,
          portraitImageURL: portraitImageURL,
          userType: userType,
        );

  static DeliveryBoyModel fromMap(Map<String, dynamic> map) {
    return DeliveryBoyModel(
      userId: int.parse(map['userId'].toString()),
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      name: map['name'],
      portraitImageURL: map['portraitImageURL'] == 'null'
          ? 'null'
          : DataBaseEndPoints.deliveryBoyPortraitImageURL +
              map['portraitImageURL'],
      userType: int.parse(map['userId'].toString()) ?? null,
      deliveryBoyId: int.parse(map['deliveryBoyId']),
      rating: double.parse(map['rating']),
      numberOfPeopleRating: int.parse(map['numberOfPeopleRating']),
      zoneNameId: int.parse(map['zoneNameId']),
      vehicleTypeId: int.parse(map['vehicleTypeId']),
      vehiclePlate: map['vehiclePlate'],
      isBusy: int.parse(map['isBusy']) == 1 ? true : false,
      startHour: _getDuratioFromString(map['startHour']),
      endHour: _getDuratioFromString(map['endHour']),
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
      'deliveryBoyId': deliveryBoyId.toString(),
      'rating': rating.toString(),
      'numberOfPeopleRating': numberOfPeopleRating.toString(),
      'zoneNameId': zoneNameId.toString(),
      'vehicleTypeId': vehicleTypeId.toString(),
      'vehiclePlate': vehiclePlate.toString(),
      'isBusy': isBusy ? '1' : '0',
      'startHour': startHour.toString(),
      'endHour': endHour.toString(),
    };
  }

  static Duration _getDuratioFromString(String timeText) {
    List<String> durationComponents = timeText.split(':');
    return Duration(
      hours: int.parse(durationComponents[0]),
      minutes: int.parse(durationComponents[1]),
    );
  }
}
