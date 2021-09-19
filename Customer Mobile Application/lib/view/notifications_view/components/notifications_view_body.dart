import 'package:flutter/material.dart';

import '../../../shared/size_configuration/text_sizes.dart';

class NotificationsViewBody extends StatefulWidget {
  NotificationsViewBody({Key key}) : super(key: key);

  @override
  _NotificationsViewBodyState createState() => _NotificationsViewBodyState();
}

class _NotificationsViewBodyState extends State<NotificationsViewBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'التنبيهات',
        style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontFamily: 'Almarai',
            fontSize: TextSizes.button,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
