import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/exported_models.dart';
import '../../shared/database_urls/data_base_urls.dart';
import '../../shared/functional_components/current_user_components.dart';
// import 'package:path/path.dart' as path;

//User Types
// Any user type is specific to the app that is installed
//These classes are only related to the customer

class AuthenticationController {
  //This is the shared authentication header
  static Map<String, String> _headers;

  //Login Method TODO: Make Shared Prefs
  Future loginUser(String phoneNumber, String password) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints
            .customerLoginURL), //+ "?user_phone=$phoneNumber&user_password=$password",
        body: {'user_phone': '$phoneNumber', 'user_password': '$password'},
      );
      // print('Status Code : ${json.decode(response.body)['code']}');
      if (json.decode(response.body)['code'] == '200') {
        Map userDetails = json.decode(response.body)['message'];
        // UserModel res = UserModel.fromMap(userDetails);
        createCustomerModel(userDetails);
        //Header must not exist until user is logged in
        //We just initialize headers here
        getAuthenticationHeader(phoneNumber, password);
        return true;
      }
      return json.decode(response.body)['result'];
    } catch (e) {
      print('Login Exceptoion ${e.message}');
      return e;
    }
  }

  createCustomerModel(Map<String, dynamic> map) {
    gbCustomerModel = CustomerModel.fromMap(map);
    print('Created User Model ${gbCustomerModel.toMap()}');
  }

  Future checkPhoneAvailability(String phoneNumber) async {
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.checkPhoneAvailabilityURL),
        body: {'phoneNumber': '$phoneNumber'},
        headers: _headers ?? {},
      );
      print(DataBaseEndPoints.checkPhoneAvailabilityURL);
      if (json.decode(response.body)['code'] == '200') {
        //TODO: Real Phone Verification Implementation Here
        String verificationCode =
            json.decode(response.body)['verification_code'];
        print('Verification Code $verificationCode');
        //Verification Code
        return verificationCode;
      }
      return json.decode(response.body)['result'];
    } catch (e) {
      return e;
    }
  }

  Future registerNewCustomer(CustomerModel customerModel) async {
    print(customerModel.toMap());
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.customerRegisterURL),
        body: (customerModel.toMap()),
        // headers: _headers,
      );
      if (json.decode(response.body)['code'] == '200') {
        //Did register Succesfully with no issues
        //Then Login user to create headers and store values successfully
        var res =
            await loginUser(customerModel.phoneNumber, customerModel.password);
        return true;
      }

      return json.decode(response.body)['result'];
    } catch (e) {
      //An Error Occured
      print('Register Method Exception $e');
      return e;
    }
  }

  Future uploadPortraitImage(File file) async {
    List<String> encodedImage = getImageEncodedToBase64(file);
    // CustomerModel currentCustomer = await getUserData();
    try {
      Response response = await post(
        Uri.parse(DataBaseEndPoints.customerUploadImageURL),
        //User phone number is required to make sure any uploaded image is for a specific user
        body: {
          "imageName": encodedImage[0],
          "image64": encodedImage[1],
          "phoneNumber": gbCustomerModel.phoneNumber.toString(),
        },
      );
      await getUserData();
      if (json.decode(response.body)['code'] == '200') {
        //Did upload Image Successfully
        return true;
      }
      return json.decode(response.body)['result'];
    } catch (e) {
      //An Error Occured
      print('Exception Occured $e');
      return e;
    }
  }

  //Encodeing the image to later be uploded using the api
  List<String> getImageEncodedToBase64(File file) {
    String newFileName = file.path.split('/').last;
    print(newFileName);
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
      print(gbCustomerModel.phoneNumber);
      Response response = await post(
        Uri.parse(DataBaseEndPoints.readCustomerDetailsURL),
        //User phone number is required to make sure any uploaded image is for a specific user
        body: {"phoneNumber": gbCustomerModel.phoneNumber.toString()},
        headers: _headers,
      );
      if (json.decode(response.body)['code'] == '200') {
        //Did upload Image Successfully
        return json.decode(response.body)['message'];
      }
      return json.decode(response.body)['result'];
    } catch (e) {
      //An Error Occured
      // print('Exception Occured ${(e as PlatformException).message}');
      return e;
    }
  }

  Future updateUserPassword(String oldPassword, String newPassword) async {
    try {
      print(gbCustomerModel.phoneNumber);
      Response response = await post(
        Uri.parse(DataBaseEndPoints.updateCustomerPasswordURL),
        //User phone number is required to make sure any uploaded image is for a specific user
        body: {
          "phoneNumber": gbCustomerModel.phoneNumber.toString(),
          'oldPassword': oldPassword,
          'newPassword': newPassword
        },
        headers: _headers,
      );
      if (json.decode(response.body)['code'] == '200') {
        //Password Changed -> Update User Data
        await loginUser(gbCustomerModel.phoneNumber, newPassword);
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
      'userinfo': basicAuth
    };
    //This assigns the shared header to  the _headers variable
    _headers = headers;
    return headers;
  }

  getGoogle() async {
    Response response =
        await get(Uri.parse(DataBaseEndPoints.checkPhoneAvailabilityURL));
    return response.body;
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
