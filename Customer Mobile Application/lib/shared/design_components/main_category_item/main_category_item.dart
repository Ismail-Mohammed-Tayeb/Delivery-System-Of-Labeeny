import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/category_model.dart';
import '../../../view/stores_for_certain_category_view/stores_for_certain_category_view.dart';
import '../../size_configuration/size_config.dart';
import '../../size_configuration/text_sizes.dart';

class MainCategoryItem extends StatefulWidget {
  //implement main category model
  final CategoryModel categoryModel;
  MainCategoryItem({this.categoryModel}) : super();
  @override
  MainCategoryItemState createState() => MainCategoryItemState();
}

class MainCategoryItemState extends State<MainCategoryItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: getProportionateScreenWidth(180),
            height: getProportionateScreenWidth(180),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.onSecondary,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(widget.categoryModel.categoryImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: getProportionateScreenWidth(180),
            height: getProportionateScreenWidth(180),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  getProportionateScreenWidth(20),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: getProportionateScreenWidth(15),
            right: getProportionateScreenWidth(10),
            child: Text(
              widget.categoryModel.categoryName,
              style: Theme.of(context).textTheme.button.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.button,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          //  InkWell(

          SizedBox(
            width: getProportionateScreenWidth(180),
            height: getProportionateScreenHeight(210),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                borderRadius: BorderRadius.circular(
                  getProportionateScreenWidth(20),
                ),
                onTap: () {
                  Get.offAndToNamed(
                    StoresForCertainCategoryView.routeName,
                    arguments: widget.categoryModel,
                  );
                },
                splashColor: Theme.of(context).accentColor.withOpacity(.08),
                highlightColor: Theme.of(context).accentColor.withOpacity(.05),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
