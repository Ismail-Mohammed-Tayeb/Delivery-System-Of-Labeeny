import 'package:flutter/material.dart';

import '../../../models/test_model_notices.dart';
import '../../../shared/size_configuration/size_config.dart';
import '../../../shared/size_configuration/text_sizes.dart';

class NotificationsViewBody extends StatefulWidget {
  NotificationsViewBody({Key key}) : super(key: key);

  @override
  _NotificationsViewBodyState createState() => _NotificationsViewBodyState();
}

class _NotificationsViewBodyState extends State<NotificationsViewBody> {
  @override
  Widget build(BuildContext context) {
    List<Notices> data = [
      Notices(
          icon: Icon(Icons.check),
          title: "تم الموافقة على طلبك",
          subTitle: "إضافة منتج جديد",
          time: "2 AM"),
      Notices(
          icon: Icon(Icons.check),
          title: "Accept your request",
          subTitle: "Add sub category",
          time: "12 Am"),
      Notices(
          icon: Icon(Icons.check),
          title: "Accept your request",
          subTitle: "Add sub category",
          time: "12 Am"),
      Notices(
          icon: Icon(Icons.check),
          title: "Accept your request",
          subTitle: "Add sub category",
          time: "12 Am"),
      Notices(
          icon: Icon(Icons.check),
          title: "Accept your request",
          subTitle: "Add sub category",
          time: "12 Am"),
      Notices(
          icon: Icon(Icons.check),
          title: "Accept your request",
          subTitle: "Add sub category",
          time: "12 Am"),
    ];
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: SizeConfiguration.screenHeight,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  tileColor: index == 1
                      ? Theme.of(context).accentColor.withOpacity(0.1)
                      : Colors.transparent,
                  leading: CircleAvatar(
                    radius: getProportionateScreenHeight(50),
                    child: data[index].icon,
                  ),
                  title: Text(
                    data[index].title,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.headline6,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.15),
                  ),
                  subtitle: Container(
                    margin:
                        EdgeInsets.only(top: getProportionateScreenHeight(10)),
                    child: Text(
                      data[index].subTitle,
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          fontFamily: 'Almarai',
                          fontSize: TextSizes.body1,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15),
                    ),
                  ),
                  trailing: Text(
                    data[index].time,
                  ),
                  // onTap: () {},
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.withOpacity(0.5),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
