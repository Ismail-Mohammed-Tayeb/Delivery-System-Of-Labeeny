abstract class DataBaseEndPoints {
  static const String _serverURL = 'YOUR_SERVER_BASE_URL';
  //Base URL To Later Be Changed To Host URL
  static const String _baseURL = _serverURL + '/api/vendor';
  //Product Management Base URL
  static const String _productManagementBaseURL =
      _baseURL + '/products_management';
  //Store Management Base URL
  static const String _storeManagementBaseURL = _baseURL + '/store_management';
//Location Api Base URL
  static const String _locationApiBaseURL = _baseURL + '/locationApi';
  //Authentication URL
  static const String loginURL = _baseURL + '/login.php';
  static const String vendorDataURL = _baseURL + '/read_vendor_by_number.php';
  static const String vendorPasswordUpdateURL =
      _baseURL + '/update_password.php';

  //Product Managment URLs
  static const String addProductURL =
      _productManagementBaseURL + '/add_product.php';
  static const String readProductsByApprovalStatusURL =
      _productManagementBaseURL + '/read_products.php';
  static const String changeProductStatusURL =
      _productManagementBaseURL + '/change_product_status.php';

  //Store management URLs
  static const String readSubCategoriesFromCategoryIdURL =
      _storeManagementBaseURL + '/read_sub_category.php';
  static const String recommendSubCategoryURL =
      _storeManagementBaseURL + '/request_sub_category.php';
  static const String readSubCategoryRequestsURL =
      _storeManagementBaseURL + '/read_sub_category_request.php';

  //Images URLs
  //Customer Images URL
  static const String vendorImageURL = _serverURL + '/images/vendor/';
  //TODO: Add Upload URL Here
  static const String vendorUploadImageURL = _serverURL + '';

  //Store Data URL
  static const String storeDataURL =
      _storeManagementBaseURL + '/read_store.php';
  //Product Images URL
  static const String productImagesURL = _serverURL + '/images/product/';
  //Category Images URL
  static const String categoryImagesURL = _serverURL + '/images/category/';
  //Store Images
  static const String storeBannerImageURL =
      _serverURL + '/images/store/banner/';
  static const String storeLogoImageURL = _serverURL + '/images/store/logo/';

  //Location API URLS
  static const String getZoneNameModelFromId =
      _locationApiBaseURL + '/get_zone_name_from_id.php';

  //Vendor Related URLs
  static const String vendorDataUpdate = _baseURL + '/update_vendor.php';
  // //Category Managment URLs
  // static const String categoryManagmentBaseURL =
  //     baseURL + '/category_management';
  // static const String readAllCategoriesURL =
  //     categoryManagmentBaseURL + '/read_category.php';
  // static const String readStoresFromCategoryIdURL =
  //     categoryManagmentBaseURL + '/read_stores_from_category.php';

  // static const String deleteCategoryURL =
  //     categoryManagmentBaseURL + '/delete_category.php';
  // static const String editCategoryImageURL =
  //     categoryManagmentBaseURL + '/edit_category_image.php';
  // static const String editCategoryNameURL =
  //     categoryManagmentBaseURL + '/edit_category_name.php';
  // static const String addSubCategoryToCategoryURL =
  //     categoryManagmentBaseURL + '/add_sub_category.php';
  // static const String editSubCategoryNameURL =
  //     categoryManagmentBaseURL + '/edit_sub_category.php';
  // static const String deleteSubCategoryURL =
  //     categoryManagmentBaseURL + '/delete_sub_category.php';
}
