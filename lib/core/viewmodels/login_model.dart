import 'package:flutter/foundation.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/services/authentication_services.dart';

import '../../service_locator.dart';
import 'base_model.dart';
/// Represents the state of the view
class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String errorMessage;

  Future<bool> login(String userIdText) async {
    setState(ViewState.Busy);
    var userId = int.tryParse(userIdText);
    if (userId == null) {
      errorMessage = 'Value entered is not a number';
      setState(ViewState.Idle);
      return false;
    }
    var success =  await _authenticationService.login(userId);
    setState(ViewState.Idle);
    return success;
  }

}