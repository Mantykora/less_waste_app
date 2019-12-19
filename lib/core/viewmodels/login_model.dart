import 'package:flutter/foundation.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/services/auth.dart';
import 'package:less_waste_app/core/services/authentication_services.dart';

import '../../service_locator.dart';
import 'base_model.dart';
/// Represents the state of the view
class LoginModel extends BaseModel {
  final AuthService _authenticationService =
      locator<AuthService>();

  String errorMessage;

  Future login(String email, String password) async {
    setState(ViewState.Busy);
    //var userId = int.tryParse(userIdText);
//    if (userId == null) {
//      errorMessage = 'Value entered is not a number';
//      setState(ViewState.Idle);
//      return false;
//    }
    await _authenticationService.signIn(email, password);

    setState(ViewState.Idle);
    //return success;
  }

}