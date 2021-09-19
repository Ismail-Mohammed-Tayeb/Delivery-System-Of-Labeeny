import 'package:flutter/material.dart';

import '../../../../controllers/category_controllers/category_controller.dart';
import '../../../../controllers/product_controllers/product_management_controller.dart';
import '../../../../models/exported_models.dart';
import '../../../../shared/size_configuration/size_config.dart';
import '../../../../shared/size_configuration/text_sizes.dart';
import '../show_product_alert_dialog/show_product_alert_dialog.dart';

class StoreProductViewBody extends StatefulWidget {
  final StoreModel storeModel;
  const StoreProductViewBody({@required this.storeModel}) : super();
  @override
  _StoreProductViewBodyState createState() => _StoreProductViewBodyState();
}

class _StoreProductViewBodyState extends State<StoreProductViewBody> {
  @override
  Widget build(BuildContext context) {
    return buildProductListFromAttribute();
  }

  List<List<ProductModel>> _sortedData = <List<ProductModel>>[];
  FutureBuilder buildProductListFromAttribute() {
    return FutureBuilder<List<ProductModel>>(
      future: ProductManagementController()
          .getAllProductsByStoreId(widget.storeModel.storeId),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            ///TODO: Convert To [CustomCircularProgressIndicator();]
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data.length == 0) {
          return Container(
            height: getProportionateScreenHeight(500),
            child: Center(child: Text('لا يوجد منتجات')),
          );
        }
        sortDataToSeperatedLists(snapshot.data);
        return Container(
          height: SizeConfiguration.screenHeight,
          // width: double.infinity,
          child: buildProductsListView(),
        );
      },
    );
  }

  Widget buildProductsListView() {
    // return ListView();
    return FutureBuilder<List<SubCategoryModel>>(
      future: CategoryController()
          .getSubCategoriesFromCategoryId(widget.storeModel.mainCategoryId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            ///TODO: Convert To [CustomCircularProgressIndicator();]
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _sortedData.length,
          itemBuilder: (context, index) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: ExpansionTile(
                iconColor:  Theme.of(context).iconTheme.color,
                collapsedIconColor:Theme.of(context).iconTheme.color ,
                initiallyExpanded: true,
                title: Builder(
                  builder: (context) {
                    String subCategoryName;
                    for (SubCategoryModel item in snapshot.data) {
                      if (item.subCategoryId ==
                          _sortedData[index][0].subCategoryId) {
                        subCategoryName = item.subCategoryName;
                        break;
                      }
                    }
                    return Text(
                      subCategoryName,
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontFamily: 'Almarai',
                            fontSize: TextSizes.headline5,
                            // color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15,
                          ),
                    );
                  },
                ),
                children: buildChildren(index),
              ),
            );
          },
        );
      },
    );
  }

  void sortDataToSeperatedLists(List<ProductModel> data) {
    _sortedData.clear();
    Map<int, List<ProductModel>> mappedData = <int, List<ProductModel>>{};
    for (ProductModel item in data) {
      if (mappedData.containsKey(item.subCategoryId)) {
        mappedData[item.subCategoryId].add(item);
        continue;
      }
      mappedData[item.subCategoryId] = <ProductModel>[];
      mappedData[item.subCategoryId].add(item);
    }
    try {
      mappedData.forEach((int key, List<ProductModel> value) {
        _sortedData.add(value);
      });
    } catch (e) {
      print('Exception Occured Here $e');
    }
  }

  List<Widget> buildChildren(int index) {
    List<Widget> widgets = [];
    for (var item in _sortedData[index]) {
      widgets.add(
        buildSubCategoryContainer(item),
      );
    }
    return widgets;
  }

  Widget buildSubCategoryContainer(ProductModel item) {
    return InkWell(
      onTap: () {
        showProductAlertDialog(item);
      },
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
              child: Container(
                width: double.infinity,
                height: getProportionateScreenWidth(140),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      offset: Offset(0, 1),
                      blurRadius: 2.5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Column(
                        children: [
                          Container(
                            width: getProportionateScreenWidth(140),
                            height: getProportionateScreenWidth(140),
                            decoration: BoxDecoration(
                              // color: Colors.transparent,
                              borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(
                                  getProportionateScreenWidth(25),
                                ),
                                bottomEnd: Radius.circular(
                                  getProportionateScreenWidth(25),
                                ),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(item.productImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(getProportionateScreenWidth(7)),
                        width: getProportionateScreenWidth(240),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(
                              getProportionateScreenWidth(25),
                            ),
                            bottomStart: Radius.circular(
                              getProportionateScreenWidth(25),
                            ),
                          ),
                        ),
                        child: Column(
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.productName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.body1,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(height: getProportionateScreenHeight(10)),
                            Text(
                              item.productDescription,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.subtitle2,
                                  ),
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(height: getProportionateScreenHeight(40)),
                            Text(
                              '${item.productPrice.toString()} SYP',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.subtitle2,
                                      fontWeight: FontWeight.bold),
                              textDirection: TextDirection.rtl,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
