abstract class DataBaseEndPoints {
  static const String _serverURL = 'YOUR_SERVER_BASE_URL';
  static const String _baseURL = _serverURL + '/api/delivery_boy';
  static const String _orderApiBaseURL = _baseURL + '/orderApi';
  static const String _imagesBaseURL = _serverURL + '/images';
  static const String _zoneNameBaseURL = _baseURL + '/locationApi';
  static const String _pushNotoficationBaseURL =
      _serverURL + '/api/push_notification';
  //Push Notifications URLS
  static const String updateDeviceTokeURL =
      _pushNotoficationBaseURL + '/shared/update_device_token.php';
  //Zone Name URLS
  static const String getZoneNameFromIdURL =
      _zoneNameBaseURL + '/get_zone_name_from_id.php';

  //Authentication URLs
  static const String deliveryBoyLoginURL = _baseURL + '/login.php';
  //DeliveryBoy Status URLs
  static const String deliveryBoyStatusURL =
      _orderApiBaseURL + '/get_delivery_boy_status.php';
  //Order Related URLs
  static const String availableOrdersURL =
      _orderApiBaseURL + '/get_available_orders.php';
  static const String takeOrderByDeliveryBoyURL =
      _orderApiBaseURL + '/take_order.php';
  static const String getOrderByDeliveryBoyAndOrderStatusURL =
      _orderApiBaseURL + '/get_order_by_status.php';
  //DeliveryBoy Images URLs
  static const String deliveryBoyPortraitImageURL =
      _imagesBaseURL + '/delivery_boy_images/';
  //Store Details
  static const String storeDetailsURL =
      _orderApiBaseURL + '/get_store_details.php';
  //Store Images
  static const String storeBannerImageURL =
      _serverURL + '/images/store/banner/';
  static const String storeLogoImageURL = _serverURL + '/images/store/logo/';
}
