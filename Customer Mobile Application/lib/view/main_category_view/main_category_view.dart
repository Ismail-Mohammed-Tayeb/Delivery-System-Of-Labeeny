import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../shared/size_configuration/text_sizes.dart';
import '../search_view/search_view.dart';
import 'components/main_category_view_body/main_category_view_body.dart';

class MainCategoryView extends StatefulWidget {
  MainCategoryView({Key key}) : super(key: key);

  @override
  _MainCategoryViewState createState() => _MainCategoryViewState();
}

class _MainCategoryViewState extends State<MainCategoryView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'الرئيسية',
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontFamily: 'Almarai',
                  fontSize: TextSizes.headline6,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  navigator.pushReplacementNamed(SearchView.routeName);
                },
              )
            ],
          ),
          SliverToBoxAdapter(child: MainVategoryViewBody()),
        ],
      ),
    );
  }
}
