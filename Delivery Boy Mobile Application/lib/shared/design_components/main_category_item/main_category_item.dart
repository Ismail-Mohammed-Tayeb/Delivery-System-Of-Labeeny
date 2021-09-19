import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../size_configuration/size_config.dart';
import '../../size_configuration/text_sizes.dart';

class MainCategoryItem extends StatefulWidget {
  //implement main category model
  MainCategoryItem(
      {this.imageUrl, this.categoryName, this.onTap, this.routeName})
      : super();
  final String imageUrl;
  final String categoryName;
  final Function onTap;
  final String routeName;

  @override
  MainCategoryItemState createState() => MainCategoryItemState();
}

class MainCategoryItemState extends State<MainCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: getProportionateScreenWidth(180),
          height: getProportionateScreenHeight(210),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
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
              image: NetworkImage(widget.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: getProportionateScreenWidth(180),
          height: getProportionateScreenHeight(210),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.3),
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
            widget.categoryName,
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
            )
              ,
            onTap: () {
              
              Get.offAndToNamed(widget.routeName,
                  arguments: widget.categoryName);
            }, //TODO:NOTE  implicit send catagoryName to another page
                  splashColor: Theme.of(context).accentColor.withOpacity(.08),
                highlightColor: Theme.of(context).accentColor.withOpacity(.05),
                ),
          ),
        ),
      ],
    );
  }
}
