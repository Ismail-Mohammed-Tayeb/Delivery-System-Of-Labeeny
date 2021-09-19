import 'dart:convert';
import 'dart:math' as Math;

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/exported_models.dart';

abstract class GeoLocationApiController {
  static RxDouble latitude = 0.0.obs;
  static RxDouble longitude = 0.0.obs;
  static RxString currentLocationName = ''.obs;
  static LocationModel currentChosenLocation;
  //Makes use of the Mobile gps to get user location
  static Future<LocationModel> getCurrentLocation() async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      LocationModel locationModel = LocationModel(
          latitude: currentPosition.latitude,
          longitude: currentPosition.longitude);
      latitude.value = locationModel.latitude;
      longitude.value = locationModel.longitude;
      await getLocationNameFromCoordinates();
      return locationModel;
    } catch (e) {
      print('Exception Occured $e');
      return null;
    }
  }

  static Future<String> getLocationNameFromCoordinates() async {
    try {
      currentChosenLocation =
          LocationModel(latitude: latitude.value, longitude: longitude.value);
      String requestURL =
          'https://maps.googleapis.com/maps/api/geocode/json?address=$latitude,$longitude'
          '&key=AIzaSyDiKif9h_5F8hNnTIOkqsZwc8GT6IIYYe0';
      print(requestURL);
      http.Response response = await http.get(Uri.parse(requestURL));
      if (latitude.value == 0 || longitude.value == 0) {
        return 'Error';
      }
      if (response.statusCode == 200) {
        // print(response.body);
        var res = json.decode(response.body);
        print(res['results'][0]['formatted_address']);
        currentLocationName.value =
            res['results'][0]['formatted_address'].toString();
      }
      return currentLocationName.value.toString();
    } catch (e) {
      print(e);
      return 'Error';
    }
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
    return d / 1000; // in kilometers
  }
}
