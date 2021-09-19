import 'package:flutter/material.dart';

import '../../shared/size_configuration/text_sizes.dart';
import 'components/notifications_view_body.dart';

class NotificationsView extends StatefulWidget {
  NotificationsView({Key key}) : super(key: key);

  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
          automaticallyImplyLeading: false,
              elevation: 0.0,
              floating: true,
            title: Text(
              'التنبيهات',
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontFamily: 'Almarai',
                  fontSize: TextSizes.headline6,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15),
            ),
          ),
          SliverToBoxAdapter(
            child: NotificationsViewBody(),
          )
        ],
      ),
    );
  }
}
