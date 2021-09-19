import 'dart:convert';

import 'package:http/http.dart';

import '../../model/requests_models/sub_category_request_model.dart';
import '../../model/store_related_models/sub_category_model.dart';
import '../../shared/database_urls/data_base_urls.dart';
import '../authentication_controllers/auth_controller.dart';
import 'store_controller.dart';

class CategoryController {
  Future<bool> recommedSubCategory(String subCategoryName) async {
    SubCategoryRequestModel requestModel = SubCategoryRequestModel(
      // Send VendorId Instead Of UserId
      vendorId: AuthenticationController.gbVendorModel.vendorId,
      storeId: StoreController.gbStoreModel.storeId,
      mainCategoryId: StoreController.gbStoreModel.mainCategoryId,
      subCategoryName: subCategoryName,
      requestDate: DateTime.now(),
    );

    try {
      print(requestModel.toMap());
      Response response = await post(
        Uri.parse(DataBaseEndPoints.recommendSubCategoryURL),
        body: {
          'vendorId': requestModel.vendorId.toString(),
          'storeId': requestModel.storeId.toString(),
          'mainCategoryId': requestModel.mainCategoryId.toString(),
          'subCategoryName': requestModel.subCategoryName.toString(),
          'requestDate': requestModel.requestDate.toString(),
        },
      );
      Map result = json.decode(response.body);
      print(result['code']);
      if (result['code'] == '200') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception Occured $e');
      return false;
    }
  }

  Future<List<SubCategoryModel>> getSubCategoriesFromCategoryId() async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.readSubCategoriesFromCategoryIdURL),
        body: {
          'categoryId': StoreController.gbStoreModel.mainCategoryId.toString()
        },
      );

      // print(response.body);
      Map result = json.decode(response.body);
      if (result['code'] == '200') {
        List<SubCategoryModel> allStores = <SubCategoryModel>[];

        for (Map<String, dynamic> item in result['message']) {
          allStores.add(SubCategoryModel.fromMap(item));
        }
        return allStores;
      } else {
        return [];
      }
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }
}
