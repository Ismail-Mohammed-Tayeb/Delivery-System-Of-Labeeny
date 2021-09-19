import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../view/auth_views/contact_us/contact_us_view.dart';
import '../../view/auth_views/login_view/login_view.dart';
import '../../view/auth_views/register_views/phone_number_register_view/phone_number_register_view.dart';
import '../../view/cart_view/cart_view.dart';
import '../../view/loading_screen/loading_screen_view.dart';
import '../../view/search_view/search_view.dart';
import '../../view/store_product_view/store_product_view.dart';
import '../../view/stores_for_certain_category_view/stores_for_certain_category_view.dart';
import '../../view/wrapper_view/wrapper_view.dart';

List<GetPage> listGetPage = [
  GetPage(
    name: LoginView.routeName,
    page: () => LoginView(),

  ),
  GetPage(
    name: PhoneNumberRegisterView.routeName,
    page: () => PhoneNumberRegisterView(),
  ),
  // GetPage(
  //   name: DataCompletionView.routeName,
  //   page: () => DataCompletionView(),
  // ),
  GetPage(
    name: ContactUsView.routeName,
    page: () => ContactUsView(),
  ),
  GetPage(
    name: WrapperView.routeName,
    page: () => WrapperView(),
    transition: Transition.rightToLeft,
    transitionDuration: Duration(milliseconds: 200),
  ),
  GetPage(
    name: SearchView.routeName,
    page: () => SearchView(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 200),
  ),
  GetPage(
    name: StoresForCertainCategoryView.routeName,
    page: () => StoresForCertainCategoryView(),
    transition: Transition.leftToRight,
    transitionDuration: Duration(milliseconds: 200),
  ),
  GetPage(
    name: StoreProductView.routeName,
    page: () => StoreProductView(),
  ),
  GetPage(
    name: CartView.routeName,
    page: () => CartView(),
  ),
  GetPage(
    name: LoadingScreenView.routeName,
    page: () => LoadingScreenView(),
  )
  // GetPage(
  //   name: RateDeliveryBoyView.routeName,
  //   page: () => RateDeliveryBoyView(),
  //   transition: Transition.leftToRight,
  //   transitionDuration: Duration(milliseconds: 200),
  // ),
];
