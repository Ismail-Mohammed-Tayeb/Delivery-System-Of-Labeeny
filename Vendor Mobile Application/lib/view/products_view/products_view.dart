import 'package:flutter/material.dart';

import '../../shared/size_configuration/text_sizes.dart';
import 'components/products_view_body.dart';

class ProductsView extends StatefulWidget {
  ProductsView({Key key}) : super(key: key);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(
                  'المنتجات',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.headline6,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15,
                      ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelStyle: Theme.of(context).textTheme.button.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.body2,
                        fontWeight: FontWeight.bold),
                    tabs: [
                      Tab(
                        text: 'المقبولة',
                      ),
                      Tab(
                        text: 'قيد الانتظار',
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              ProductsViewBody(showIsApprovedProducts: 1),
              ProductsViewBody(showIsApprovedProducts: 0),
            ],
          ),
          physics: BouncingScrollPhysics(),
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
