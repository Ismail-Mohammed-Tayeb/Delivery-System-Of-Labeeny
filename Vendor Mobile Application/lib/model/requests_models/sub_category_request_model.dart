import 'package:flutter/foundation.dart';

class SubCategoryRequestModel {
  int requestId;
  int vendorId;
  int storeId;
  int mainCategoryId;
  String subCategoryName;
  DateTime requestDate;
  DateTime responseDate;
  //0 - Refused
  //1 - Pending
  //2 - Approved
  int responseStatus;
  String responseMessage;
  int managerId;
  SubCategoryRequestModel({
    this.requestId,
    @required this.vendorId,
    @required this.storeId,
    @required this.mainCategoryId,
    @required this.subCategoryName,
    @required this.requestDate,
    this.responseDate,
    this.responseStatus,
    this.responseMessage,
    this.managerId,
  });

  //TODO: Add Null Validation Here
  static SubCategoryRequestModel fromMap(Map<String, dynamic> data) {
    return SubCategoryRequestModel(
      requestId: int.parse(data['requestId']),
      vendorId: int.parse(data['vendorId']),
      storeId: int.parse(data['storeId']),
      mainCategoryId: int.parse(data['mainCategoryId']),
      subCategoryName: data['subCategoryName'],
      requestDate: DateTime.parse(data['requestDate']),
      responseDate: data['responseDate'] == null
          ? null
          : DateTime.parse(data['responseDate']),
      responseStatus: data['responseStatus'] == null
          ? null
          : int.parse(data['responseStatus']),
      responseMessage: data['responseMessage'],
      managerId:
          data['managerId'] == null ? null : int.parse(data['managerId']),
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      // 'requestId': requestId.toString(),
      'vendorId': vendorId.toString(),
      'storeId': storeId.toString(),
      'mainCategoryId': mainCategoryId.toString(),
      'subCategoryName': subCategoryName,
      'requestDate': requestDate.toString(),
      'responseDate':
          responseDate == null ? null.toString() : responseDate.toString(),
      'responseStatus':
          responseStatus == null ? null.toString() : responseStatus.toString(),
      'responseMessage':
          responseMessage == null ? null.toString() : responseMessage,
      'managerId': managerId == null ? null.toString() : managerId.toString(),
    };
  }
}
