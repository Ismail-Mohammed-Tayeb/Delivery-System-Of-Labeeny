import 'package:flutter/foundation.dart';

class UserModel {
  int userId;
  String phoneNumber;
  String password;
  String name;
  String portraitImageURL;
  int userType;
  UserModel({
    @required this.userId,
    @required this.phoneNumber,
    @required this.password,
    @required this.name,
    @required this.portraitImageURL,
    @required this.userType,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    //Converting from Map To Object
    return UserModel(
      userId: int.parse(map['userId'].toString()),
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      name: map['name'],
      portraitImageURL: map['portraitImageURL'],
      userType: int.parse(map['userId'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'userId': this.userId,
      'phoneNumber': this.phoneNumber,
      'password': this.password,
      'name': this.name,
      'portraitImageURL': this.portraitImageURL,
      'userType': this.userType,
    };
  }
}
