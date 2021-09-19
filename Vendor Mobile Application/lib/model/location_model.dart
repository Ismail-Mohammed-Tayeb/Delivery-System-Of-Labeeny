import 'package:flutter/foundation.dart';

class LocationModel {
  double latitude;
  double longitude;
  LocationModel({
    @required this.latitude,
    @required this.longitude,
  });

  static LocationModel fromString(String location) {
    return LocationModel(
      latitude: double.parse(location.split(',')[0]),
      longitude: double.parse(location.split(',')[1]),
    );
  }

  String toString() {
    return '${this.latitude.toString()},${this.longitude.toString()}';
  }
}
