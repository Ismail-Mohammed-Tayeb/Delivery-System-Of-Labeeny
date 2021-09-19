import 'dart:convert';

import '../zone_name_controllers/zone_name_controller.dart';
import '../../models/district_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../../models/cart_product_model.dart';
import '../../models/exported_models.dart';
import '../../models/order_model.dart';
import '../../shared/database_urls/data_base_urls.dart';
import '../../shared/functional_components/current_user_components.dart';
import '../location_controllers/geo_location_controller.dart';
import '../store_related_controllers/store_controller.dart';

class CartController {
  ///Represents All the Products That Are Currently In The Customers Cart
  static int currentStoreId = -1;
  static RxList<CartProductModel> currentCart = <CartProductModel>[].obs;

  bool addProductToList(CartProductModel cartProductModel) {
    if (!productAlreadyExists(cartProductModel.product.productId)) {
      if (cartProductModel.product.storeId != currentStoreId) {
        currentCart.clear();
        currentStoreId = cartProductModel.product.storeId;
      }
      currentCart.add(cartProductModel);
      return true;
    }
    return false;
  }

  /// This Method Checks If A Product already Exists and returns `true` if so, `false` otherwise
  bool productAlreadyExists(int productId) {
    for (CartProductModel item in currentCart) {
      if (item.product.productId == productId) return true;
    }
    return false;
  }

  /// Make Sure This Method Is Only Called On Existing Cart Products
  removeProduct(int productId) {
    for (CartProductModel item in currentCart) {
      if (item.product.productId == productId) {
        /// Once the product is found and removed
        /// there is no need to continue iterating over the list
        currentCart.remove(item);
        return;
      }
    }
  }

  makeNewQuantityToExistingProductInCart(int productId, int newValue) {
    for (CartProductModel item in currentCart) {
      if (item.product.productId == productId) {
        /// Once the product is found increment and return
        /// there is no need to continue iterating over the list
        item.productQuantity = newValue;
        return;
      }
    }
  }

  /// Gets The Total Price Of The Cart Items
  static double getTotalCartPrice() {
    double totalPrice = 0;
    for (CartProductModel item in currentCart) {
      totalPrice += (item.productQuantity * item.product.productPrice);
    }
    return totalPrice;
  }

  clearProductsFromCart() {
    currentCart.clear();
  }

  static Future<bool> submitOrderToDatabse(String orderNotes) async {
    try {
      StoreModel currentStoreModel = await StoreController.getStoreById(
          currentCart.first.product.storeId.toString());
      if (GeoLocationApiController.currentChosenLocation == null) {
        //This means that no location was chosen
        //so the method needs to exit and show a message that says
        //Please Pick a Valid Location
        return false;
      }
      String cartProductsDetails = '';
      double sumOfPrices = getTotalCartPrice();
      int cartSize = 0;
      for (int i = 0; i < currentCart.length; i++) {
        cartSize += currentCart[i].product.productSize;
        cartProductsDetails +=
            '${currentCart[i].product.productId}|${currentCart[i].product.productName}|'
            '${currentCart[i].product.productPrice}|${currentCart[i].productQuantity}';
        if (i == currentCart.length - 1) continue;
        cartProductsDetails += ',';
      }
      DistrictModel storeDistrictModel =
          await ZoneNameController.getDistrictModelFromZoneNameId(
              currentStoreModel.zoneNameId);
      //Get District Model For Current Store
      //This Means that the customer can now read this value as the delivery price.
      double deliveryFee =
          GeoLocationApiController.calculateDistanceInKilometers(
                  GeoLocationApiController.currentChosenLocation,
                  currentStoreModel.location) *
              storeDistrictModel.pricePerKm;

      print(
          'Whole Cart Price Is: ${sumOfPrices.toString()}+${deliveryFee.toString()}'
          ' = ${(sumOfPrices + deliveryFee).toString()}');

      OrderModel currentOrder = OrderModel(
        //Since The store id is the same in all cart products
        //Setting the store name from any product is okay
        //for simplicity and minimal code using first is convinient
        storeId: currentCart.first.product.storeId,
        customerId: gbCustomerModel.userId,
        wholeCartPrice: (sumOfPrices + deliveryFee),
        deliveryFee: deliveryFee,
        cartProductDetails: cartProductsDetails,
        orderLocation: GeoLocationApiController.currentChosenLocation,
        // A Unique generated hash code from time-based function
        orderQr: Uuid().v1(),
        orderStatus: 0,
        submittionDate: DateTime.now(),
        targetedDeliveryBoysZoneId: currentStoreModel.zoneNameId,
        wholeOrderSize: cartSize,
        orderNote: orderNotes ?? '',
      );

      ///Determines whether the response code was 200 and the respnse succeeded or not
      bool httpResponseResult = await _makeHttpRequestToDatabse(currentOrder);

      ///If the response result was true then clear the cart
      if (httpResponseResult) {
        currentCart.clear();
      }
      return httpResponseResult;
    } catch (e) {
      print('Exception Occured $e');
      return false;
    }
  }

  static Future<bool> _makeHttpRequestToDatabse(OrderModel orderModel) async {
    try {
      http.Response response = await http.post(
        Uri.parse(DataBaseEndPoints.addOrderURL),
        body: orderModel.toMap(),
        // body: body,
      );
      Map result = json.decode(response.body);
      if (result['code'] == '200') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception Occured $e');
      return false;
    }
  }

  ///TODO: Future Perspectives: Make this method to later query on a certain date
  static Future<List<OrderModel>> getAllCustomerOrdersByCompletionValue(
      int orderStatus) async {
    try {
      http.Response response = await http.post(
        Uri.parse(DataBaseEndPoints.getOrderByOrderStatusURL),
        body: {
          'orderStatus': orderStatus.toString(),
          'customerId': gbCustomerModel.userId.toString(),
        },
      );
      Map result = json.decode(response.body);
      if (result['code'] == '200') {
        List<OrderModel> allOrders = <OrderModel>[];
        for (Map<String, dynamic> item in result['message']) {
          allOrders.add(OrderModel.fromMap(item));
        }
        return allOrders;
      } else {
        return [];
      }
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }

  static Future<List<OrderModel>> getAllInCompleteOrders() async {
    List<OrderModel> orders = <OrderModel>[];
    List<OrderModel> byOrderStatus0 =
        await getAllCustomerOrdersByCompletionValue(0);
    List<OrderModel> byOrderStatus1 =
        await getAllCustomerOrdersByCompletionValue(1);
    orders.addAll(byOrderStatus1);
    orders.addAll(byOrderStatus0);
    return orders;
  }

  static Future<List<OrderModel>> getAllCompleteOrders() async {
    List<OrderModel> orders = <OrderModel>[];
    List<OrderModel> byOrderStatus0 =
        await getAllCustomerOrdersByCompletionValue(2);
    List<OrderModel> byOrderStatus1 =
        await getAllCustomerOrdersByCompletionValue(3);
    orders.addAll(byOrderStatus1);
    orders.addAll(byOrderStatus0);
    return orders;
  }
}
