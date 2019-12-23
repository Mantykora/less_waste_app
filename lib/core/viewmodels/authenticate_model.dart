import 'package:flutter/foundation.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/services/auth.dart';
import 'package:less_waste_app/core/services/authentication_services.dart';

import '../../service_locator.dart';
import 'base_model.dart';
/// Represents the state of the view
class AuthenticateModel extends BaseModel {

  bool isSignInView = true;

  final AuthService _authenticationService =
  locator<AuthService>();


  void toggleView() {
    setState(ViewState.Busy);
    isSignInView = !isSignInView;
    setState(ViewState.Idle);
  }


  String errorMessage;

  Future login(String email, String password) async {
    setState(ViewState.Busy);
    //var userId = int.tryParse(userIdText);
//    if (userId == null) {
      //errorMessage = 'Value entered is not a number';
//      setState(ViewState.Idle);
//      return false;
//    }

    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

    if(password.isEmpty || email.isEmpty) {
      errorMessage = 'Enter e-mail and password';
      setState(ViewState.Idle);
      return null;
    }
    else if (password.length < 5)  {
      errorMessage = 'Password must contain at least 5 characters';
      setState(ViewState.Idle);
      return null;
    }
    else if (!emailValid) {
      errorMessage = 'Please enter a valid e-mail address';
      setState(ViewState.Idle);
      return null;
    }

    var response =  await _authenticationService.signIn(email, password);

    if (response == null) {
      errorMessage = null;
      setState(ViewState.Idle);
      return null;
    }

    //return response;

    setState(ViewState.Idle);
    //return success;
  }

  Future register() {

  }


}