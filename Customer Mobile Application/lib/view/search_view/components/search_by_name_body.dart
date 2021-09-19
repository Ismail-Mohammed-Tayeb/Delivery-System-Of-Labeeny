import 'package:flutter/material.dart';

import '../../../controllers/category_controllers/category_search_controller.dart';
import '../../../models/exported_models.dart';
import '../../../shared/design_components/custom_first_sub_category_item/custom_first_sub_category_item.dart';
import '../../../shared/design_components/custom_progress_indicator/custom_progress_indicator.dart';
import '../../../shared/size_configuration/size_config.dart';

buildSearchByNameBody(String storeName) {
  if (storeName == null) {
    return Center(
      child: Text('يرجى ملئ حقل البحث'),
    );
  }
  return FutureBuilder<List<StoreModel>>(
    future: CategorySearchController().searchStoresByName(storeName.trim()),
    builder: (context, snapshot) {
      if (snapshot.data == null || !snapshot.hasData) {
        return Center(
          child: CustomCircularProgressIndicator(),
        );
      }
      //To Dismiss Keyboard Later when a search result Appears
      if (snapshot.data.length == 0) {
        return Center(child: Text('لم يتم العثور على نتيجة'));
      }
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: getProportionateScreenWidth(20)),
            child: Container(
              width: getProportionateScreenWidth(375),
              child: CustomFirstSubCategoryItem(
                storeModel: snapshot.data[index],
              ),
            ),
          );
        },
      );
    },
  );
}
