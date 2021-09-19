import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../controller/notification_controller.dart';
import '../../../model/requests_models/sub_category_request_model.dart';
import '../../../shared/design_components/custom_circular_progress_indicator/custom_circular_progress_indicator.dart';
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
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: buildFutureBuilderBody());
  }

  buildFutureBuilderBody() {
    return FutureBuilder<List<SubCategoryRequestModel>>(
        //TODO: Show All Notifications Here
        future: NotificationController()
            .getSubCategoryRecommendationRequestNotificaction(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: CustomCircularProgressIndicator());
          }
          if (snapshot.data.length == 0) {
            return Center(
              child: Text('لا يوجد تنبيهات'),
            );
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return buildNotificationItem(snapshot.data[index]);
            },
          );
        });
  }

  buildNotificationItem(SubCategoryRequestModel requestModel) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Slidable(
        actions: [
          IconSlideAction(
            color: Theme.of(context).errorColor,
            icon: CommunityMaterialIcons.delete,
            onTap: () => print('Delete'),
          ),
        ],
        actionPane: SlidableDrawerActionPane(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: getProportionateScreenHeight(5)),
              child: ListTile(
                tileColor: requestModel.responseStatus == 0
                    ? Theme.of(context).accentColor.withOpacity(0.3)
                    : Colors.transparent,
                leading: CircleAvatar(
                  radius: getProportionateScreenHeight(50),
                  child: Icon(Icons.check),
                ),
                title: Text(
                  'حالة قبول صنف فرعي: ${requestModel.subCategoryName}',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.headline6,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.15),
                ),
                subtitle: Container(
                  margin:
                      EdgeInsets.only(top: getProportionateScreenHeight(10)),
                  child: Text(
                    requestModel.responseMessage == null
                        ? "لايوجد رسالة حالية"
                        : requestModel.responseMessage,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.body1,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15),
                  ),
                ),
                trailing: Text(
                  requestModel.responseDate == null
                      ? requestModel.requestDate.toString().substring(0, 10)
                      : requestModel.responseDate.toString().substring(0, 10),
                ),
                // onTap: () {},
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey.withOpacity(0.5),
            )
          ],
        ),
      ),
    );
  }
}
