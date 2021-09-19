import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_models/vendor_model.dart';
import '../../shared/database_urls/data_base_urls.dart';

//User Types
// Any user type is specific to the app that is installed
//These classes are only related to the vendor

class AuthenticationController {
  static VendorModel gbVendorModel;
  //This is the shared authentication header
  static Map<String, String> _headers;

  //Login Method TODO: Make Shared Prefs
  Future loginUser(String phoneNumber, String password) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints
            .loginURL), //+ "?user_phone=$phoneNumber&user_password=$password",
        body: {'phoneNumber': '$phoneNumber', 'password': '$password'},
      );
      print(json.decode(response.body)['message']);
      if (json.decode(response.body)['code'] == '200') {
        Map userDetails = json.decode(response.body)['message'];
        createGlobalVendorModel(userDetails);
        getAuthenticationHeader(phoneNumber, password);
        return true;
      }
      return json.decode(response.body)['result'];
    } catch (e) {
      print(e);
      return e;
    }
  }

  createGlobalVendorModel(Map<String, dynamic> map) {
    gbVendorModel = VendorModel.fromMap(map);
    print('Created User Model ${gbVendorModel.toMap()}');
  }

  Future uploadPortraitImage(File file) async {
    List<String> encodedImage = getImageEncodedToBase64(file);
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.vendorUploadImageURL),
        body: {
          "imageName": encodedImage[0],
          "image64": encodedImage[1],
          "phoneNumber": gbVendorModel.phoneNumber.toString(),
        },
        headers: _headers,
      );
      if (json.decode(response.body)['code'] == '200') {
        //Did upload Image Successfully
        return true;
      }
      return json.decode(response.body)['result'];
    } catch (e) {
      //An Error Occured
      print('Exception Occured');
      return e;
    }
  }

  //Encodeing the image to later be uploded using the api
  List<String> getImageEncodedToBase64(File file) {
    String newFileName = file.path.split('/').last;
    print(newFileName);
    // print('Image Path Name : ${path.basename(file.path)}');
    //print('New File Name Is $newPath');
    //Renaming the file to later be named as so in the File System on server
    // file = file.renameSync(newFileName);
    String encodedImage = base64Encode(file.readAsBytesSync());
    List<String> toReturn = [
      newFileName,
      encodedImage,
    ];
    return toReturn;
  }

  Future getUserData() async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.vendorDataURL),
        //User phone number is required to make sure any uploaded image is for a specific user
        body: {"phoneNumber": gbVendorModel.phoneNumber.toString()},
        headers: _headers,
      );
      print(response.body);
      if (json.decode(response.body)['code'] == '200') {
        //Did upload Image Successfully
        return json.decode(response.body)['message'];
      }
      return json.decode(response.body)['result'];
    } catch (e) {
      //An Error Occured
      return e;
    }
  }

  Future updateUserPassword(String oldPassword, String newPassword) async {
    try {
      print(gbVendorModel.phoneNumber);
      Response response = await post(
        Uri.parse(DataBaseEndPoints.vendorPasswordUpdateURL),
        //User phone number is required to make sure update is for a specific user
        body: {
          "phoneNumber": gbVendorModel.phoneNumber.toString(),
          'oldPassword': oldPassword,
          'newPassword': newPassword
        },
        headers: _headers,
      );
      if (json.decode(response.body)['code'] == '200') {
        //Password Changed -> Update User Data
        await loginUser(gbVendorModel.phoneNumber, newPassword);
        return json.decode(response.body)['message'];
      }
      return json.decode(response.body)['result'];
    } catch (e) {
      //An Error Occured
      // print('Exception Occured ${(e as PlatformException).message}');
      return e;
    }
  }

  Map<String, String> getAuthenticationHeader(
      String phoneNumber, String password) {
    String basicAuth = base64Encode(utf8.encode('$phoneNumber:$password'));
    Map<String, String> headers = {
      'Access-Control-Allow-Origin': ' *',
      // 'Content-Type': 'application/json; charset=UTF-8',
      // "HOST": "labiny.000webhostapp.com",
      'userinfo': basicAuth
    };
    //This assigns the shared header to  the _headers variable
    _headers = headers;
    return headers;
  }

  writeCredentialsToSharedPreferences(
      String phoneNumber, String password) async {
    try {
      //Write Credentials to local storage to check if the user has previously logged in
      Future<SharedPreferences> _localPrefs = SharedPreferences.getInstance();
      final SharedPreferences localPrefs = await _localPrefs;
      localPrefs.setString('phoneNumber', phoneNumber);
      localPrefs.setString('password', password);
      print('Wrote Preferences True');
      //If So Then no storage premission is required and thus the user can login
    } catch (e) {
      //If an error occured than TODO: Show toast saying that a storage error has occured
      //And make a tip that says you should enable storage permission to asure
      //that login credentials are saved successfully
      print('Wrote Preferences False');
    }
  }

  readCredentialsFromSharedPreferences() async {
    String phoneNumber, password;
    try {
      Future<SharedPreferences> _localPrefs = SharedPreferences.getInstance();
      final SharedPreferences localPrefs = await _localPrefs;
      phoneNumber = localPrefs.getString('phoneNumber');
      password = localPrefs.getString('password');
      print('Read Preferences True');
      return {
        'phoneNumber': phoneNumber,
        'password': password,
      };
    } catch (e) {
      print('Read Preferences False');
      return null;
    }
  }
}
