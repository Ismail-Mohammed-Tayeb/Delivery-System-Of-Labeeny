import '../../controllers/authentication_controllers/auth_controller.dart';
import '../../models/exported_models.dart';

//This file stores the current user and the authentication controller
//So that no initialization of any of the following is required
CustomerModel gbCustomerModel;
final AuthenticationController authenticationController =
    AuthenticationController();
