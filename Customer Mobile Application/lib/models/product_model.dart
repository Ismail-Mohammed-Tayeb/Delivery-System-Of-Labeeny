import 'package:flutter/cupertino.dart';

import '../shared/database_urls/data_base_urls.dart';

class ProductModel {
  int productId;
  int storeId;
  int subCategoryId;
  String productName;
  String productDescription;
  double productPrice;
  int productSize;
  String productImage;

  /// `isApproved` == 0 Pending
  /// `isApproved` == 1 Approved
  /// `isApproved` == 2 Disabled
  int isApproved;
  ProductModel({
    this.productId,
    this.storeId,
    this.subCategoryId,
    @required this.productName,
    @required this.productDescription,
    @required this.productPrice,
    @required this.productSize,
    this.productImage,
    this.isApproved,
  });

  Map<String, String> toMap() {
    return <String, String>{
      'productId': productId.toString(),
      'storeId': storeId.toString(),
      'subCategoryId': subCategoryId.toString(),
      'productName': productName,
      'productDescription': productDescription,
      'productPrice': productPrice.toString(),
      'productSize': productSize.toString(),
      'productImage': productImage,
      'isApproved': isApproved.toString(),
    };
  }

  static ProductModel fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: int.parse(map['productId']),
      storeId: int.parse(map['storeId']),
      subCategoryId: int.parse(map['subCategoryId']),
      productName: map['productName'],
      productDescription: map['productDescription'],
      productPrice: double.parse(map['productPrice']),
      productSize: int.parse(map['productSize']),
      productImage: DataBaseEndPoints.productImagesURL + map['productImage'],
      isApproved: int.parse(map['isApproved']),
    );
  }
}
