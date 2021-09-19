import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'shared/design_components/custom_notification/custom_notification.dart';
import 'shared/design_components/theme/dark_theme/dark_theme.dart';
import 'shared/design_components/theme/light_theme/light_theme.dart';
import 'shared/routes/routes.dart';
import 'view/auth_views/login_view/login_view.dart';
import 'view/loading_screen/loading_screen_view.dart';

//Push-Notification Related Methods For Handling Firebase Messaging Services
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Handling Opening the application if the notification is recieved in the background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) async {
      //TODO: Implement Local Notofication To Handle Good Manners When Showing Notifications Inside App
      print('Got a message whilst in the foreground!');
      if (message.notification != null) {
        print('Body :${message.notification?.body}');
        print('Title :${message.notification?.title}');
        await showCustomNotification(
            message.notification?.body, message.notification.title);
      }
    },
  );
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(CustomTheme(savedThemeMode: savedThemeMode));
}

class CustomTheme extends StatelessWidget {
  final AdaptiveThemeMode savedThemeMode;
  const CustomTheme({this.savedThemeMode}) : super();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'حدث خطأ يرجى إعادة تحميل التطبيق\nوالتأكد من حالة الاتصال بالشبكة',
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Wrapper(doneLoading: true);
        }
        return Wrapper(doneLoading: false);
      },
    );
  }
}

class Wrapper extends StatelessWidget {
  final bool doneLoading;
  const Wrapper({@required this.doneLoading}) : super();

  @override
  Widget build(BuildContext context) {
    print(doneLoading);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AdaptiveTheme(
        light: lightTheme(),
        dark: darkTheme(),
        initial: AdaptiveThemeMode.system,
        builder: (lightTheme, darkTheme) => GetMaterialApp(
          title: 'Labeeny - Delivery Boy',
          textDirection: TextDirection.rtl,
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          // initialRoute: LoginView.routeName,
          home: doneLoading ? LoginView() : LoadingScreenView(),
          getPages: listGetPage,
        ),
      ),
    );
  }
}
