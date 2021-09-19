import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/product_controllers/product_management_controller.dart';
import '../../../controller/store_controller/category_controller.dart';
import '../../../model/store_related_models/product_model.dart';
import '../../../model/store_related_models/sub_category_model.dart';
import '../../../shared/design_components/custom_circular_progress_indicator/custom_circular_progress_indicator.dart';
import '../../../shared/size_configuration/size_config.dart';
import '../../../shared/size_configuration/text_sizes.dart';
import 'add_product_alert_dialog.dart';
import 'recommend_sub_category_alert_dialog.dart';

class ProductsViewBody extends StatefulWidget {
  final int showIsApprovedProducts;
  const ProductsViewBody({@required this.showIsApprovedProducts}) : super();
  @override
  _ProductsViewBodyState createState() => _ProductsViewBodyState();
}

class _ProductsViewBodyState extends State<ProductsViewBody> {
  //TODO: Add The Ability To Set Product To Disabled
  @override
  Widget build(BuildContext context) {
    return buildProductListFromAttribute(widget.showIsApprovedProducts);
  }

  RxBool _floatingActionsOpened = false.obs;
  List<List<ProductModel>> _sortedData = <List<ProductModel>>[];
  Scaffold buildProductListFromAttribute(int isApproved) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButtonWithOptions(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder<List<ProductModel>>(
          future:
              ProductManagementController().getAllProductsByStatus(isApproved),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: CustomCircularProgressIndicator(),
              );
            }
            if (snapshot.data.length == 0) {
              return Center(
                child: Text(
                  'لا يوجد لديك منتجات',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.button,
                      fontWeight: FontWeight.bold),
                ),
              );
            }
            sortDataToSeperatedLists(snapshot.data);
            return buildProductsListView();
          },
        ),
      ),
    );
  }

  Widget buildProductsListView() {
    // return ListView();
    return FutureBuilder<List<SubCategoryModel>>(
      future: CategoryController().getSubCategoriesFromCategoryId(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
            child: CustomCircularProgressIndicator(),
          );
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _sortedData.length,
          itemBuilder: (context, index) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: ExpansionTile(
                iconColor: Theme.of(context).iconTheme.color,
                collapsedIconColor: Theme.of(context).iconTheme.color,
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
                            fontSize: TextSizes.headline6,
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

  Padding buildFloatingActionButtonWithOptions() {
    return Padding(
      padding: EdgeInsets.only(right: getProportionateScreenHeight(35)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FloatingActionButton(
            foregroundColor: Theme.of(context).accentColor,
            child: Icon(
              Icons.add,
              size: getProportionateScreenWidth(30),
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              _floatingActionsOpened.value = !_floatingActionsOpened.value;
            },
          ),
          Obx(() {
            return _floatingActionsOpened.value
                ? Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: getProportionateScreenHeight(35),
                        ),
                        //TODO: Theme Elevated Buttons Here
                        child: ElevatedButton(
                          onPressed: () {
                            addProductAlertDialog();
                          },
                          child: Text(
                            'إضافة منتج',
                            style: Theme.of(context).textTheme.button.copyWith(
                                fontFamily: 'Almarai',
                                fontSize: TextSizes.button,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: getProportionateScreenHeight(35),
                        ),
                        //TODO: Theme Elevated Buttons Here
                        child: ElevatedButton(
                          onPressed: () {
                            recommendSubCategoryAlertDialog();
                          },
                          child: Text(
                            'إقتراح صنف فرعي',
                            style: Theme.of(context).textTheme.button.copyWith(
                                fontFamily: 'Almarai',
                                fontSize: TextSizes.button,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink();
          }),
        ],
      ),
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

  Row buildSubCategoryContainer(ProductModel item) {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(8)),
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
                            borderRadius: BorderRadiusDirectional.all(
                              Radius.circular(
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
                            item.productName, //TODO: MenuItems name
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.body1,
                                      fontWeight: FontWeight.bold,
                                    ),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            item.productDescription,
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.subtitle2,
                                    ),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(40),
                          ),
                          Text(
                            '${item.productPrice.toString()} ل.س',
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
    );
  }
}
