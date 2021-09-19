import '../../controllers/authentication_controllers/auth_controller.dart';
import '../../models/delivery_boy_model.dart';

//This file stores the current user and the authentication controller
//So that no initialization of any of the following is required
DeliveryBoyModel gbDeliveryBoyModel;
final AuthenticationController authenticationController =
    AuthenticationController();
