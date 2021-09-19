import 'package:flutter/material.dart';

class SizeConfiguration {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  // static double defaultSize;
  // static Orientation orientation;
  //Text Size
  static double headline1;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    // orientation = _mediaQueryData.orientation;
    headline1 = getProportionateScreenWidth(20);
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfiguration.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 810.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfiguration.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 400.0) * screenWidth;
}
