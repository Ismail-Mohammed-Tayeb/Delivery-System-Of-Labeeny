import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../shared/size_configuration/size_config.dart';
import '../../shared/size_configuration/text_sizes.dart';
import '../wrapper_view/wrapper_view.dart';
import 'components/search_by_name_body.dart';
import 'components/search_by_product_name_body.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);
  static String routeName = 'SearchView';

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String txtSearch;
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: Theme.of(context),
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0.0,
                  floating: true,
                  brightness: Theme.of(context).brightness,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  actions: [
                    IconButton(
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(8),
                          bottom: getProportionateScreenWidth(9),
                          top: getProportionateScreenWidth(11)),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        // Navigator.pushReplacementNamed(
                        //     context, MainCategoryView.routeName);
                        Get.offAndToNamed(
                          WrapperView.routeName,
                        );
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(8),
                                bottom: getProportionateScreenWidth(10),
                                top: getProportionateScreenWidth(12)),
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'ابحث عن : مطعم, متجر أو منتج',
                                hintStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle
                                    .copyWith(
                                      fontSize: TextSizes.body2,
                                      fontFamily: 'Almarai',
                                    ),
                                contentPadding:
                                    EdgeInsets.only(right: 20, top: 2),
                                suffixIcon: Icon(
                                  Icons.search_outlined,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                              onChanged: (txt) {
                                txt.length > 0
                                    ? txtSearch = txt
                                    : txtSearch = null;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SliverPersistentHeader(
                  floating: true,
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      labelStyle: Theme.of(context).textTheme.button.copyWith(
                          fontFamily: 'Almarai',
                          fontSize: TextSizes.body2,
                          fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(
                          text: 'المتاجر',
                        ),
                        Tab(
                          text: 'المنتجات',
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Container(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  buildSearchByNameBody(txtSearch),
                  buildSearchByProductNameBody(txtSearch),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
