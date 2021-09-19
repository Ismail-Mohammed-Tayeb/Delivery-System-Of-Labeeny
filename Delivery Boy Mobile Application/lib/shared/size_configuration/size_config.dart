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
  // double screenHeight = SizeConfiguration.screenHeight;
  if (SizeConfiguration.screenHeight >= 1024) {
    return (inputHeight / 810.0) * SizeConfiguration.screenHeight;
  }
  // 812 is the layout height that designer use
  //for mobile size
  else
    return (inputHeight / 1024.0) * SizeConfiguration.screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  if (SizeConfiguration.screenWidth >= 768.0) {
    return (inputWidth / 768.0) * SizeConfiguration.screenWidth;
  }
  // 375 is the layout width that designer use
  else
    return (inputWidth / 400.0) * SizeConfiguration.screenWidth;
}
