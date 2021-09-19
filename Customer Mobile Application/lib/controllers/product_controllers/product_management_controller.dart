import 'dart:convert';

import 'package:http/http.dart';

import '../../models/exported_models.dart';
import '../../shared/database_urls/data_base_urls.dart';

class ProductManagementController {
  Future<List<ProductModel>> getAllProductsByStoreId(int storeId) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.readProductsByStoreId),
        body: {
          'storeId': storeId.toString(),
        },
      );
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
}
