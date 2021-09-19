import 'dart:math' as Math;
import 'package:delivery_boy_application/models/location_model.dart';
import 'package:geolocator/geolocator.dart';

abstract class GeoLocationApiController {
  static Future<double> calculateDistanceFromCurrentLocationInKilometers(
      LocationModel locationModel) async {
    Position geoLocationVal = await Geolocator.getCurrentPosition();
    LocationModel currentLocation = LocationModel(
        latitude: geoLocationVal.latitude, longitude: geoLocationVal.longitude);
    return calculateDistanceInKilometers(currentLocation, locationModel);
  }

  static double calculateDistanceInKilometers(
      LocationModel position1, LocationModel position2) {
    // 33.528213, 36.302762
    final R = 6371e3; // metres
    final teta1 = position1.latitude * Math.pi / 180; // teta, lambda in radians
    final teta2 = position2.latitude * Math.pi / 180;
    final deltateta = (position2.latitude - position1.latitude) * Math.pi / 180;
    final deltalambda =
        (position2.longitude - position1.longitude) * Math.pi / 180;
    double a = Math.sin(deltateta / 2) * Math.sin(deltateta / 2) +
        Math.cos(teta1) *
            Math.cos(teta2) *
            Math.sin(deltalambda / 2) *
            Math.sin(deltalambda / 2);
    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    double d = R * c; // in meters
    return (d / 1000).abs(); // in kilometers
  }
}
