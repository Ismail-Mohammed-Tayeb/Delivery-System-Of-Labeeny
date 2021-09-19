import 'package:flutter/material.dart';

import '../../shared/size_configuration/text_sizes.dart';
import 'components/notifications_view_body.dart';

//TODO: Implement FlutterNotification to show when sending a new recommendation request
class NotificationsView extends StatefulWidget {
  NotificationsView({Key key}) : super(key: key);

  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              // floating: true,
              title: Text(
                'التنبيهات',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.headline6,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15),
              ),
            ),
          ];
        },
        body: NotificationsViewBody(),
        physics: BouncingScrollPhysics(),
      ),
    );
  }
}
