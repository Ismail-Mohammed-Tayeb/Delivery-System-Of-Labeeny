import 'package:flutter/foundation.dart';

import '../shared/database_urls/data_base_urls.dart';
import 'location_model.dart';

class StoreModel {
  int storeId;
  int vendorId;
  String storeName;
  String logoImage;
  String bannerImage;
  String quote;
  double rating;
  int mainCategoryId;
  LocationModel location;
  int zoneNameId;
  StoreModel({
    @required this.storeId,
    @required this.vendorId,
    @required this.storeName,
    @required this.logoImage,
    @required this.bannerImage,
    @required this.quote,
    @required this.rating,
    @required this.mainCategoryId,
    @required this.location,
    @required this.zoneNameId,
  });

  static StoreModel fromMap(Map<String, dynamic> map) {
    return StoreModel(
      storeId: int.parse(map['storeId']),
      vendorId: int.parse(map['vendorId']),
      storeName: map['storeName'],
      logoImage: DataBaseEndPoints.storeLogoImageURL + map['logoImage'],
      bannerImage: DataBaseEndPoints.storeBannerImageURL + map['bannerImage'],
      quote: map['quote'],
      rating: double.parse(map['rating']),
      mainCategoryId: int.parse(map['mainCategoryId']),
      location: LocationModel.fromString(map['location']),
      zoneNameId: int.parse(map['zoneNameId']),
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'storeId': storeId.toString(),
      'vendorId': vendorId.toString(),
      'storeName': storeName,
      'logoImage': logoImage,
      'bannerImage': bannerImage,
      'quote': quote,
      'rating': rating.toString(),
      'mainCategoryId': mainCategoryId.toString(),
      'branches': location.toString(),
    };
  }
}
