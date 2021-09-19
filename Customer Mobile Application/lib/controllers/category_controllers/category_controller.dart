import 'dart:convert';

import 'package:http/http.dart';

import '../../models/category_model.dart';
import '../../models/exported_models.dart';
import '../../shared/database_urls/data_base_urls.dart';
import '../../shared/functional_components/current_user_components.dart';
import '../authentication_controllers/auth_controller.dart';

class CategoryController {
  // static String _categoriesImageURL =
  //     "http://192.168.1.200:82/test_test/images/category/";
  // static String _categoryStoreBannerImageURL =
  //     "http://192.168.1.200:82/test_test/images/store/banner/";
  // static String _categoryStoreLogoImageURL =
  //     "http://192.168.1.200:82/test_test/images/store/logo/";

  ///Gets All Categories to be shown in the main List Of Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.getAllCategories),
        headers: AuthenticationController().getAuthenticationHeader(
          gbCustomerModel.phoneNumber,
          gbCustomerModel.password,
        ),
      );
      Map result = json.decode(response.body);
      if (result['code'] == '200') {
        List<CategoryModel> allCategories = <CategoryModel>[];
        for (Map<String, dynamic> item in result['message']) {
          allCategories.add(CategoryModel.fromMap(item));
        }
        return allCategories;
      } else {
        return [];
      }
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }

  Future<List<StoreModel>> getStoresFromCategoryId(String categoryId) async {
    print(categoryId);
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.getAllStoresURL),
        body: {'categoryId': categoryId},
        headers: AuthenticationController().getAuthenticationHeader(
          gbCustomerModel.phoneNumber,
          gbCustomerModel.password,
        ),
      );

      Map result = json.decode(response.body);
      if (result['code'] == '200') {
        List<StoreModel> allStores = <StoreModel>[];
        for (Map<String, dynamic> item in result['message']) {
          allStores.add(StoreModel.fromMap(item));
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

  /// This Method Shall Return All Subcategories From the recieved categories
  /// Referring to Each Store Alone !!
  Future<List<SubCategoryModel>> getSubCategoriesFromCategoryId(
      int categoryId) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.readSubCategoriesFromCategoryIdURL),
        body: {'categoryId': categoryId.toString()},
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
