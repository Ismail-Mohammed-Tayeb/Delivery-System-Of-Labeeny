import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../shared/database_urls/data_base_urls.dart';
import '../../shared/functional_components/current_user_components.dart';

abstract class UserDataController {
  static Future<bool> updateUserData(String newName, [File newImage]) async {
    try {
      List<String> imageData = <String>[];
      if (newImage != null) {
        print('Encoding Image ..');
        imageData = _getImageEncodedToBase64(newImage);
        print('Encoding Image Done');
      }
      Response response = await post(
        Uri.parse(DataBaseEndPoints.customerDataUpdate),
        body: newImage == null
            ? {
                'userId': gbCustomerModel.userId.toString(),
                'name': newName,
                'imageName': 'null',
                'image64': 'null',
              }
            : {
                'userId': gbCustomerModel.userId.toString(),
                'name': newName,
                'imageName': imageData[0],
                'image64': imageData[1],
              },
      );
      print(json.decode(response.body)['result']);
      if (json.decode(response.body)['code'] == '200') {
        //Did update data successfully
        return true;
      }
      return false;
    } catch (e) {
      print('Exception Occured While Updating User Data: ${e.message}');
      return null;
    }
  }

  //Encodeing the image to later be uploded using the api
  static List<String> _getImageEncodedToBase64(File file) {
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
}
