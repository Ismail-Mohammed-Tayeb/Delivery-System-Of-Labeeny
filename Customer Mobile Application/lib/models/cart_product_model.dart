import 'package:flutter/foundation.dart';

import 'product_model.dart';

class CartProductModel {
  int productQuantity;
  ProductModel product;
  CartProductModel({
    @required this.productQuantity,
    @required this.product,
  });
}
