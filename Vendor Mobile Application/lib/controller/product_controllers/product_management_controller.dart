import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../model/store_related_models/product_model.dart';
import '../../shared/database_urls/data_base_urls.dart';
import '../store_controller/store_controller.dart';

class ProductManagementController {
  Future<bool> addProduct(ProductModel productModel, File file) async {
    List<String> encodedImage = getImageEncodedToBase64(file);
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.addProductURL),
        body: {
          'storeId': StoreController.gbStoreModel.storeId.toString(),
          'subCategoryId': productModel.subCategoryId.toString(),
          'productName': productModel.productName,
          'productDescription': productModel.productDescription,
          'productPrice': productModel.productPrice.toString(),
          'productSize': productModel.productSize.toString(),
          'imageName': encodedImage[0],
          'image64': encodedImage[1],
        },
      );
      if (json.decode(response.body)['code'] == '200') {
        return true;
      }
      return false;
    } catch (e) {
      print('Exception Occured: ${e.message}');
      return false;
    }
  }

  List<String> getImageEncodedToBase64(File file) {
    String newFileName = file.path.split('/').last;
    print(newFileName);
    // print('Image Path Name : ${path.basename(file.path)}');
    //print('New File Name Is $newPath');
    //Renaming the file to later be named as so in the File System on server
    // file = file.renameSync(newFileName);
    String encodedImage = base64Encode(file.readAsBytesSync());
    List<String> toReturn = [
      newFileName,
      encodedImage,
    ];
    return toReturn;
  }

  Future<List<ProductModel>> getAllProductsByStatus(int isApproved) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.readProductsByApprovalStatusURL),
        body: {
          'storeId': StoreController.gbStoreModel.storeId.toString(),
          'isApproved': isApproved.toString(),
        },
      );

      // print(response.body);
      Map result = json.decode(response.body);
      if (result['code'] == '200') {
        List<ProductModel> allProducts = <ProductModel>[];

        for (Map<String, dynamic> item in result['message']) {
          allProducts.add(ProductModel.fromMap(item));
        }
        return allProducts;
      } else {
        return [];
      }
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }

  ///Setting the `isApproved` to 1 Sets the Product as Enabled
  ///
  ///Setting  `isApproved` to 2 Sets the Product as Disabled
  ///
  ///Note: This Method Shall Not be called among the creation of pending
  ///
  ///products because it is ONLY used to toggle status between [disabled ]
  ///
  ///and [enabled], since the User Manager is responsible for making the
  ///
  ///product approved and Set to enabled by default; `isApproved = 1`
  Future<bool> setProductStatusToDisabled(int productId, int isApproved) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.changeProductStatusURL),
        body: {
          'productId': productId.toString(),
          'isApproved': isApproved.toString()
        },
      );
      Map result = json.decode(response.body);
      if (result['code'] == '200') return true;
      return false;
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }
}
