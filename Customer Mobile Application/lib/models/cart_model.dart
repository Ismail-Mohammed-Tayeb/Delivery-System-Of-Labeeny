import 'package:flutter/cupertino.dart';

import 'cart_product_model.dart';

/// TODO: Continue Implementing this Model
class CartModel {
  int cartId;
  int storeId;
  List<CartProductModel> cart;
  bool isDone;
  CartModel({
    this.cartId,
    @required this.storeId,
    @required this.cart,
    this.isDone = false,
  });
}
