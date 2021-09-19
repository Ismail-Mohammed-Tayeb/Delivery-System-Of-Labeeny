import 'dart:convert';

import 'package:http/http.dart';

import '../../models/delivery_boy_model.dart';
import '../../shared/database_urls/data_base_urls.dart';
import '../../shared/functional_components/current_user_components.dart';

class AuthenticationController {
  Future loginUser(String phoneNumber, String password) async {
    try {
      print("try login");
      Response response = await post(
        Uri.parse(DataBaseEndPoints.deliveryBoyLoginURL),
        body: {'phoneNumber': '$phoneNumber', 'password': '$password'},
      );
      if (json.decode(response.body)['code'] == '200') {
        print("messege ${json.decode(response.body)['message']}");
        Map userDetails = json.decode(response.body)['message'];
        createDeliveryBoyModel(userDetails);
        return true;
      }
      else{
        print("messege ${json.decode(response.body)['code']}");
        
      }
      return json.decode(response.body)['result'];
    } catch (e) {
      print('Exception Occured: ${e.message}');
      return e;
    }
  }

  createDeliveryBoyModel(Map<String, dynamic> map) {
    gbDeliveryBoyModel = DeliveryBoyModel.fromMap(map);
    print('Created User Model ${gbDeliveryBoyModel.toMap()}');
  }
}
