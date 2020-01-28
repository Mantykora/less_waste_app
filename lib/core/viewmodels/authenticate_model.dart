import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/services/auth.dart';

import '../../service_locator.dart';
import 'base_model.dart';
import 'package:flutter/services.dart';


/// Represents the state of the view
class AuthenticateModel extends BaseModel {
  bool isSignInView = true;

  final AuthService _authenticationService = locator<AuthService>();

  String errorMessage;

  void toggleView() {
    setState(ViewState.Busy);
    isSignInView = !isSignInView;
    errorMessage = null;
    setState(ViewState.Idle);
  }

  Future login(String email, String password) async {
    setState(ViewState.Busy);

    bool isValidated = await validateCredentials(login: null, email: email, password: password);
    if (!isValidated) return null;

    var response;

      response = await _authenticationService.signIn(email, password);


    if (response == null) {
      errorMessage = null;
      setState(ViewState.Idle);
      return null;
    }

    setState(ViewState.Idle);
  }

  Future register(
    String login,
    String email,
    String password,
  ) async {
    setState(ViewState.Busy);
    validateCredentials(login: login, email: email, password: password);

    bool isValidated = await validateCredentials(login: login, email: email, password: password);
    if (!isValidated) return null;
    var response = await _authenticationService.register(login, email, password);

    if(response != null){
      isSignInView = true;
      setState(ViewState.Idle);
      print(response.toString());
            switch(response.toString()) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Twój adres email jest nieprawidłowy.";
          return null;
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "Istnieje już konto założone na podany adres email.";
          print('istnieje');
          return null;
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Spróbuj ponownie później.";
          return null;
          break;
        case "ERROR_NETWORK_ERROR":
          errorMessage = "Błąd połączenia.";
          return null;
          break;
        default:
          errorMessage = null;
          return null;
      }
    }

    if (response == null) {
      errorMessage = null;
      setState(ViewState.Idle);
      return null;
    }


    isSignInView = true;
    setState(ViewState.Idle);
  }

  Future<bool> validateCredentials({
    String login,
    String email,
    String password,
  }) async {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

    if (password.isEmpty || email.isEmpty) {
      errorMessage = 'All fields are required';
      setState(ViewState.Idle);
      return false;
    } else if (password.length < 6) {
      errorMessage = 'Password must contain at least 6 characters';
      setState(ViewState.Idle);
      return false;
    } else if (!emailValid) {
      errorMessage = 'Please enter a valid e-mail address';
      setState(ViewState.Idle);
      return false;
    }

    return true;
  }
}
