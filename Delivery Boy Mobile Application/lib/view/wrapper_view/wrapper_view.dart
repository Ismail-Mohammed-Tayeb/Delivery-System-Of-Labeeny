import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../shared/size_configuration/size_config.dart';
import '../../shared/size_configuration/text_sizes.dart';
import '../notifications_view/notifications_view.dart';
import '../offers_view/offers_view.dart';
import '../requests_view/requests_view.dart';
import '../user_profie_view/user_profie_view.dart';

class WrapperView extends StatefulWidget {
  WrapperView({Key key}) : super(key: key);
  static String routeName = 'WrapperView';

  @override
  _WrapperViewState createState() => _WrapperViewState();
}

class _WrapperViewState extends State<WrapperView> {
  bool selectedFilter = true;

  int indexPage = 0;
  final _page = [
    OffersView(),
    RequestsView(),
    NotificationsView(),
    UserProfieView(),
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: Theme.of(context),
      duration: Duration(milliseconds: 500),
      child: Scaffold(
          bottomNavigationBar: Directionality(
            textDirection: TextDirection.rtl,
            child: GNav(
              backgroundColor: Theme.of(context).primaryColor,
              rippleColor: Theme.of(context)
                  .accentColor
                  .withOpacity(.2), // tab button ripple color when pressed
              hoverColor: Theme.of(context)
                  .accentColor
                  .withOpacity(.1), // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 25,
              curve: Curves.easeInOutSine, // tab animation curves
              duration: Duration(microseconds: 500), // tab animation duration
              gap: 10, // the tab button gap between icon and text
              color: Colors.grey, // unselected icon color
              activeColor: Theme.of(context)
                  .iconTheme
                  .color, // selected icon and text color
              iconSize: getProportionateScreenWidth(25), // tab button icon size
              tabBackgroundColor: Theme.of(context)
                  .accentColor
                  .withOpacity(0.2), // selected tab background color
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              // navigation bar padding
              textStyle: Theme.of(context).textTheme.button.copyWith(
                  fontFamily: 'Almarai',
                  fontSize: TextSizes.button,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.15,
                  color: Theme.of(context).iconTheme.color),
              tabs: [
                GButton(
                  icon: CommunityMaterialIcons.home_outline,
                  text: 'العروض',
                ),
                GButton(
                  icon: CommunityMaterialIcons.truck_fast_outline,
                  text: 'طلباتي',
                ),
                GButton(
                  icon: CommunityMaterialIcons.bell_outline,
                  text: 'التنبيهات',
                ),
                GButton(
                  icon: CommunityMaterialIcons.account_outline,
                  text: 'صفحتي',
                ),
              ],
              onTabChange: (i) {
                setState(() {
                  indexPage = i;
                });
              },
            ),
          ),
          body: _page[indexPage]),
    );
  }
}
