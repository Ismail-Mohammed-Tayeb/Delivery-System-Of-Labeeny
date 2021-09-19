import 'package:flutter/material.dart';

import '../../shared/size_configuration/text_sizes.dart';
import 'components/finished_request_body/finished_request_body.dart';
import 'components/pending_request_body/pending_request_body.dart';
import 'components/qr_dialog/qr_dialog.dart';

class RequestsView extends StatefulWidget {
  RequestsView({Key key}) : super(key: key);

  @override
  _RequestsViewState createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: Text(
                  'طلباتي',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.headline6,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15,
                      ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      qrAlertDialog();
                    },
                    icon: Icon(
                      Icons.qr_code_scanner_sharp,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  )
                ],
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelStyle: Theme.of(context).textTheme.button.copyWith(
                          fontFamily: 'Almarai',
                          fontSize: TextSizes.body2,
                          fontWeight: FontWeight.bold,
                        ),
                    tabs: [
                      Tab(
                        text: 'الحالية',
                      ),
                      Tab(
                        text: 'المنتهية',
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: SafeArea(
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              children: [
                PendingRequestBody(),
                FinishedRequestBody(),
              ],
            ),
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
