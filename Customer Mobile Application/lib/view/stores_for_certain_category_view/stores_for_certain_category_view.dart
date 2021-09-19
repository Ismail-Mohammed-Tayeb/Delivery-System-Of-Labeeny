import 'dart:math';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/category_controllers/category_controller.dart';
import '../../models/category_model.dart';
import '../../models/exported_models.dart';
import '../../shared/design_components/custom_first_sub_category_item/custom_first_sub_category_item.dart';
import '../../shared/design_components/custom_progress_indicator/custom_progress_indicator.dart';
import '../../shared/size_configuration/size_config.dart';
import '../../shared/size_configuration/text_sizes.dart';
import '../cart_view/cart_view.dart';
import '../wrapper_view/wrapper_view.dart';

class StoresForCertainCategoryView extends StatefulWidget {
  StoresForCertainCategoryView() : super();
  static String routeName = 'FirstSubCategoryView';

  @override
  _StoresForCertainCategoryViewState createState() =>
      _StoresForCertainCategoryViewState();
}

class _StoresForCertainCategoryViewState
    extends State<StoresForCertainCategoryView> {
  //TODO: Make Global Variable since pop clears arguments
  CategoryModel categoryModel = Get.arguments as CategoryModel;
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: Theme.of(context),
      duration: Duration(milliseconds: 500),
      child: Scaffold(
          body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 0.0,
              floating: true,
              brightness: Theme.of(context).brightness,
              foregroundColor: Colors.red,
              backgroundColor: Theme.of(context).colorScheme.primary,
              expandedHeight: getProportionateScreenWidth(40),
              title: Text(
                categoryModel.categoryName,
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.headline6,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  navigator.pushReplacementNamed(WrapperView.routeName);
                },
              ),
              actions: [
                IconButton(
                  icon: Transform(
                    transform: Matrix4.rotationY(pi),
                    alignment: Alignment.center,
                    child: Icon(
                      CommunityMaterialIcons.cart_outline,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(CartView.routeName);
                  },
                )
              ],
            ),
            SliverToBoxAdapter(
              child: _buildStoresListView(),
            ),
          ],
        ),
      )),
    );
  }

  _buildStoresListView() {
    return FutureBuilder<List<StoreModel>>(
      future: CategoryController()
          .getStoresFromCategoryId(categoryModel.categoryId),
      builder: (context, snapshot) {
        if (snapshot.data == null || !snapshot.hasData) {
          return Center(
            child: CustomCircularProgressIndicator(),
          );
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
}
