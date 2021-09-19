import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../view/auth_views/contact_us/contact_us_view.dart';
import '../../view/auth_views/login_view/login_view.dart';
import '../../view/wrapper_view/wrapper_view.dart';

List<GetPage> listGetPage = [
  GetPage(
      name: LoginView.routeName,
      page: () => LoginView(),
      transition: Transition.zoom,
      transitionDuration: Duration(minutes: 500)),
  GetPage(name: ContactUsView.routeName, page: () => ContactUsView()),
  GetPage(
      name: WrapperView.routeName,
      page: () => WrapperView(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 200)),
];
