import 'dart:io';

//Before each controller or method call, to avoid any user token issues
//  make sure the user is logged in and
//Has a valid User Token
//Then make the api calls to the DB
abstract class InternetConnectionController {
  static Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
