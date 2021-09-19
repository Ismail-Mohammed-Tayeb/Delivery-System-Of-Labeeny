import 'package:flutter/foundation.dart';

import 'location_model.dart';

class OrderModel {
  int orderId;
  int storeId;
  int customerId;
  int deliveryBoyId;
  double wholeCartPrice;
  double deliveryFee;
  String cartProductDetails;

  ///Depending on this integer:
  ///
  ///The appropriate delivery boy will read this record
  ///
  ///by comparing this interger with his vehicles size
  int wholeOrderSize;

  ///This Parameter was not named `customerLocation` since
  ///
  ///the customer is allowed to send an order to any location
  ///
  ///of his desire
  LocationModel orderLocation;

  ///This Parameter Is Optional Since The Customer May Not Have Any
  ///
  ///Preferrings To Add To The Customer
  String orderNote;

  ///This Delivery QR Code is generated as a unique id (From UUID Package)
  ///
  ///To make sure that the customer has truely recieved his order and later
  ///
  ///Rate the service (Delivery Boy Specifically)
  String orderQr;

  DateTime submittionDate;
  DateTime takeOrderDate;
  DateTime deliveryDate;

  ///TODO: Add in store location
  int targetedDeliveryBoysZoneId;

  ///This parameter represents the order status where
  ///
  ///`orderStatus` == `0` This means the order Pending
  ///
  ///`orderStatus` == `1` This means the order is Taken By a DeliveryBoy
  ///
  ///`orderStatus` == `2` This means the order Was Delivered Succesfully
  ///
  ///`orderStatus` == `3` This means the order Failed
  int orderStatus;

  ///This Parameter Will be filled when a deliveryboy
  ///
  ///Accepts the order otherwise dashes are shown to the customer
  ///
  ///`approximateTimeInMinutes` == Minutes From DeliveryBoy To Vendor + From Vendor To Customer
  int approximateTimeInMinutes;
  String failureIssue;

  ///OrderId and DeliveryBoyId Might be Late Parameters To Be
  ///
  ///Filled Later in the DataBase
  OrderModel({
    this.orderId,
    @required this.storeId,
    @required this.customerId,
    this.deliveryBoyId,
    @required this.wholeCartPrice,
    @required this.deliveryFee,
    @required this.cartProductDetails,
    @required this.wholeOrderSize,
    @required this.orderLocation,
    this.orderNote,
    @required this.orderQr,
    @required this.submittionDate,
    this.takeOrderDate,
    this.deliveryDate,
    @required this.targetedDeliveryBoysZoneId,
    @required this.orderStatus,
    this.approximateTimeInMinutes,
    this.failureIssue,
  });
  Map<String, String> toMap() {
    return <String, String>{
      'orderId': orderId == null ? 'null' : orderId.toString(),
      'storeId': storeId.toString(),
      'customerId': customerId.toString(),
      'deliveryBoyId':
          deliveryBoyId == null ? 'null' : deliveryBoyId.toString(),
      'wholeCartPrice': wholeCartPrice.toString(),
      'deliveryFee': deliveryFee.toString(),
      'cartProductDetails': cartProductDetails,
      'wholeOrderSize': wholeOrderSize.toString(),
      'orderLocation': orderLocation.toString(),
      'orderNote': orderNote == null ? 'null' : orderNote,
      'orderQr': orderQr,
      'submittionDate': submittionDate.toString(),
      'takeOrderDate': takeOrderDate.toString(),
      'deliveryDate': deliveryDate == null ? 'null' : deliveryDate.toString(),
      'targetedDeliveryBoysZoneId': targetedDeliveryBoysZoneId.toString(),
      'orderSatus': orderStatus.toString(),
      'approximateTimeInMinutes': approximateTimeInMinutes == null
          ? 'null'
          : approximateTimeInMinutes.toString(),
      'failureIssue': failureIssue == null ? 'null' : failureIssue,
    };
  }

  static OrderModel fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] == null ? null : int.parse(map['orderId']),
      storeId: int.parse(map['storeId']),
      customerId: int.parse(map['customerId']),
      deliveryBoyId:
          map['deliveryBoyId'] == null ? null : int.parse(map['deliveryBoyId']),
      wholeCartPrice: double.parse(map['wholeCartPrice']),
      deliveryFee: double.parse(map['deliveryFee']),
      cartProductDetails: map['cartProductDetails'],
      wholeOrderSize: int.parse(map['wholeOrderSize']),
      orderLocation: LocationModel.fromString(map['orderLocation']),
      orderNote: map['orderNote'] == 'null' ? null : map['orderNote'],
      orderQr: map['orderQr'],
      submittionDate: DateTime.parse(map['submittionDate']),
      takeOrderDate: map['takeOrderDate'] == null
          ? null
          : DateTime.parse(map['takeOrderDate']),
      deliveryDate: map['deliveryDate'] == null
          ? null
          : DateTime.parse(map['deliveryDate']),
      targetedDeliveryBoysZoneId: int.parse(map['targetedDeliveryBoysZoneId']),
      orderStatus: int.parse(map['orderStatus']),
      approximateTimeInMinutes: map['approximateTimeInMinutes'] == null
          ? null
          : int.parse(map['approximateTimeInMinutes']),
      failureIssue: map['failureIssue'] == null ? null : map['failureIssue'],
    );
  }
}
