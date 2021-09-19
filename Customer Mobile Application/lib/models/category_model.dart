import 'package:flutter/foundation.dart';

import '../shared/database_urls/data_base_urls.dart';

class CategoryModel {
  String categoryId;
  String categoryImage;
  String categoryName;
  CategoryModel({
    @required this.categoryId,
    @required this.categoryImage,
    @required this.categoryName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'categoryImage': categoryImage,
      'categoryName': categoryName,
    };
  }

  static CategoryModel fromMap(Map<String, dynamic> data) {
    return CategoryModel(
        categoryId: data['categoryId'].toString(),
        categoryImage:
            (DataBaseEndPoints.categoryImageURL + data['categoryImage'])
                .toString(),
        categoryName: data['categoryName'].toString());
  }
}
