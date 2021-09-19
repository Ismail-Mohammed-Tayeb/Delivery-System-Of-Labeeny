import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';

import '../../shared/database_urls/data_base_urls.dart';
import '../../shared/functional_components/current_user_components.dart';

abstract class PushNotificationController {
  static FirebaseMessaging _globalMessagingObj = FirebaseMessaging.instance;
  static Future<bool> registerDeviceToken() async {
    try {
      await Firebase.initializeApp();
      await notificationAuthorizationStatus();
      //Now since the application is initialized then a token can be sent to
      // the DB
      String deviceToken;
      //TODO: Test Without While
      while (deviceToken == null) {
        deviceToken = await _globalMessagingObj.getToken();
        print('Token Is : $deviceToken');
      }
      //Here Since The Token Id Is Now Available it Can be Sent To the DB
      Response response = await post(
        Uri.parse(DataBaseEndPoints.updateDeviceTokeURL),
        body: {
          'userId': gbCustomerModel.userId.toString(),
          'deviceToken': deviceToken.toString(),
        },
      );
      var result = json.decode(response.body);
      if (result['code'] == '200') {}
      return true;
    } catch (e) {
      print('Token Exception Occured $e');
      return false;
    }
  }

  static Future<bool> notificationAuthorizationStatus() async {
    NotificationSettings settings = await _globalMessagingObj.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    print(settings.authorizationStatus);
  }
}
