import 'package:customer_labeeny/models/order_model.dart';

abstract class DataBaseEndPoints {
  static const String _serverURL = 'YOUR_SERVER_BASE_URL';

  //Base URL To Later Be Changed To Host URL
  static const String _baseURL = _serverURL + '/api/customer';
  static const String _storeApiBaseURL = _baseURL + '/storeApi';
  static const String _orderApiBaseURL = _baseURL + '/orderApi';
  static const String _searchApiURL = _baseURL + '/searchApi';
  static const String _pushNotoficationBaseURL =
      _serverURL + '/api/push_notification';
  //Push Notifications URLS
  static const String updateDeviceTokeURL =
      _pushNotoficationBaseURL + '/shared/update_device_token.php';
  //Customer Data URLs
  static const String customerUploadImageURL =
      _baseURL + '/add_profile_picture.php';
  static const String customerUploadImagePath =
      _serverURL + '/images/customer/';
  //Customer Login/Registration Management URLs
  static const String customerLoginURL = _baseURL + '/login.php';
  static const String customerRegisterURL = _baseURL + '/register.php';
  static const String customerDataUpdate = _baseURL + '/update_customer.php';
  static const String readCustomerDetailsURL =
      _baseURL + '/read_customer_by_number.php';
  static const String updateCustomerPasswordURL =
      _baseURL + '/update_password.php';
  static const String checkPhoneAvailabilityURL =
      _serverURL + '/api/shared/check_phone_availability.php';

  //Authentication URL
  static const String loginURL = _baseURL + '/login.php';
  static const String vendorDataURL = _baseURL + '/read_vendor_by_number.php';
  static const String vendorPasswordUpdateURL =
      _baseURL + '/update_password.php';

  //Product Managment URLs
  static const String readProductsByStoreId =
      _storeApiBaseURL + '/get_products.php';
  static const String readSubCategoriesFromCategoryIdURL =
      _storeApiBaseURL + '/get_sub_category.php';

  //Category Images URL
  static const String categoryImageURL = _serverURL + '/images/category/';
  //Store related URLs
  static const String storeDetailsFromIdURL =
      _storeApiBaseURL + '/get_store_by_id.php';
  static const String getVendorModelFromId =
      _storeApiBaseURL + '/get_vendor_by_id.php';
  static const String getAllCategories =
      _storeApiBaseURL + '/get_categories.php';
  static const String getAllStoresURL = _storeApiBaseURL + '/get_stores.php';

  //Search Related URLs
  static const String searchStoresByName =
      _searchApiURL + '/search_store_by_name.php';
  //Location Related URLs
  static const String zoneNameFromIdURL =
      _baseURL + '/locationApi/get_zone_name_from_id.php';
  static const String getDistrictFromZoneNameIdURL =
      _baseURL + '/locationApi/get_district_by_zone_name_id.php';
  //Order related URLs
  static const String addOrderURL = _orderApiBaseURL + '/add_order.php';
  static const String getOrderByOrderStatusURL =
      _orderApiBaseURL + '/get_orders.php';
  static const String setOrderAsDeliveredURL =
      _orderApiBaseURL + '/recieve_order.php';
  static const String getDeliveryBoyForRateFromId =
      _orderApiBaseURL + '/get_delivery_info_by_id.php';
  static const String rateDeliveryBoyById =
      _orderApiBaseURL + '/rating_delivery_boy.php';
  //Images URLs
  //Customer Images URL
  static const String vendorImageURL = _serverURL + '/images/vendor/';
  //TODO: Add Upload URL Here
  static const String vendorUploadImageURL = _serverURL + '';

  //Product Images URL
  static const String productImagesURL = _serverURL + '/images/product/';
  //Category Images URL
  static const String categoryImagesURL = _serverURL + '/images/category/';
  //Store Images
  static const String storeBannerImageURL =
      _serverURL + '/images/store/banner/';
  static const String storeLogoImageURL = _serverURL + '/images/store/logo/';
  //Delivery Boy Images
  static const String _imagesBaseURL = _serverURL + '/images';
  static const String deliveryBoyPortraitImageURL =
      _imagesBaseURL + '/delivery_boy_images/';
}
