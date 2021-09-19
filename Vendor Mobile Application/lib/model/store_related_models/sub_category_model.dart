import 'package:flutter/foundation.dart';

class SubCategoryModel {
  int subCategoryId;
  String subCategoryName;
  int mainCategoryId;
  SubCategoryModel({
    @required this.subCategoryId,
    @required this.subCategoryName,
    @required this.mainCategoryId,
  });

  static SubCategoryModel fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      subCategoryId: int.parse(map['subCategoryId']),
      subCategoryName: map['subCategoryName'],
      mainCategoryId: int.parse(map['mainCategoryId']),
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      "subCategoryId": subCategoryId.toString(),
      "subCategoryName": subCategoryName,
      "mainCategoryId": mainCategoryId.toString(),
    };
  }
}
