import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/route_manager.dart';

import '../../models/exported_models.dart';
import '../../shared/size_configuration/size_config.dart';
import '../../shared/size_configuration/text_sizes.dart';
import 'components/store_product_view_body/store_product_view_body.dart';

class StoreProductView extends StatefulWidget {
  StoreProductView() : super();
  static String routeName = 'SubCategoryMenuView';
  @override
  _StoreProductViewState createState() => _StoreProductViewState();
}

class _StoreProductViewState extends State<StoreProductView> {
  StoreModel storeModelOfCurrentView = Get.arguments as StoreModel;
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: Theme.of(context),
      duration: Duration(milliseconds: 500),
      child: Container(
        width: getProportionateScreenWidth(350),
        height: double.infinity,
        child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0.0,
                  pinned: true,
                  floating: true,
                  snap: true,
                  stretch: true,
                  brightness: Theme.of(context).brightness,
                  foregroundColor: Colors.red,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  expandedHeight: getProportionateScreenWidth(200),
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        storeModelOfCurrentView.storeName,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontFamily: 'Almarai',
                            fontSize: TextSizes.headline6,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15),
                      ),
                      background: buildAppBarBackground()),
                  leading: buildBackPageArrowButton(),
                ),
                // StoreMenuViewBody(storeModel: storeModelOfCurrentView),
                SliverToBoxAdapter(
                  child:
                      StoreProductViewBody(storeModel: storeModelOfCurrentView),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack buildAppBarBackground() {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(storeModelOfCurrentView.bannerImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Theme.of(context).primaryColor.withOpacity(0.1),
                Theme.of(context).primaryColor.withOpacity(0.5),
                Theme.of(context).primaryColor.withOpacity(0.8),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Stack buildBackPageArrowButton() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: getProportionateScreenWidth(33),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).accentColor),
            onPressed: () {
              Get.back();
            },
          ),
        )
      ],
    );
  }
}
