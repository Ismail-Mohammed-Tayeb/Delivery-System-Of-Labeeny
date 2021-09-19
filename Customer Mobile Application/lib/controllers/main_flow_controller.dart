import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared/functional_components/current_user_components.dart';

abstract class MainFlowController {
  //This class is responsible for making some desicions in the application

  //This method shall also be responsible for making sure the user is not first time login
  //And decide the appropriate screen to navigate to
  static Future<Widget> checkIfUserIsFirstTimeOpenApp() async {
    //Call shared preferences here and check if the user
    //is opening the app for the first time
    //if so then redirect user to the tips page
    //else redirect the user to the mainpage view|| Login view
    Future<SharedPreferences> _localPrefs = SharedPreferences.getInstance();
    final SharedPreferences localPrefs = await _localPrefs;
    bool _res = localPrefs.getBool('isFirstTimeLogin');
    authenticationController.readCredentialsFromSharedPreferences();
    if (_res == null) {
      print('Variable of Type bool is NULL');
      localPrefs.setBool('isFirstTimeLogin', true);
      //TODO:Redirect to Tips Page Here
      return Scaffold(
        body: Center(child: Text('The User Is First Time Opening The App')),
      );
    } else if (await authenticationController
            .readCredentialsFromSharedPreferences() ==
        null) {
      //Redirect to login page here
      return Scaffold(
        body: Center(
            child: Text(
                'Then User Is Not First Time Opening The App, But Is Not Logged In')),
      );
    } else if (await authenticationController
            .readCredentialsFromSharedPreferences() !=
        null) {
      //Then the user is not first time opening the app and is logged in
      //Call Login user and redirect user to MainCategory Screen
      await authenticationController.loginUser(
        await authenticationController
            .readCredentialsFromSharedPreferences()['phoneNumber'],
        await authenticationController
            .readCredentialsFromSharedPreferences()['password'],
      );
      //Here Return the homescreenwidget or route name
      return Scaffold(
        body: Center(
            child: Text(
                'Then the user is not first time opening the app and is logged in')),
      );
    }
  }
}
