import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/services/auth.dart';

import '../../service_locator.dart';
import 'base_model.dart';
import 'package:flutter/services.dart';

/// Represents the state of the view
class AuthenticateModel extends BaseModel {
  bool isSignInView = true;
  bool isForgotView = false;

  final AuthService _authenticationService = locator<AuthService>();

  String errorMessage;

  void toggleView() {
    setState(ViewState.Busy);
    isSignInView = !isSignInView;
    isForgotView = false;
    errorMessage = null;
    setState(ViewState.Idle);
  }

  void toggleForgot() {
    isForgotView = !isForgotView;
    errorMessage = null;
    setState(ViewState.Idle);
  }

  Future login(String email, String password) async {
    setState(ViewState.Busy);

    bool isValidated = await validateCredentials(login: null, email: email, password: password);
    if (!isValidated) return null;

    var response = await _authenticationService.signIn(email, password);

    isResponseSuccessful(response);

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
    setState(ViewState.Idle);

    isSignInView = isResponseSuccessful(response);
    isForgotView = false;
  }

  Future remindPassword(String email) async {
    setState(ViewState.Busy);
    errorMessage = null;
    var response = await _authenticationService.remindPassword(email);

    isForgotView = !isResponseSuccessful(response);
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

  String mapResponseToErrorMessage(String response) {
    switch (response.toString()) {
      case "ERROR_INVALID_EMAIL":
        return "Twój adres email jest nieprawidłowy.";
      case "ERROR_EMAIL_ALREADY_IN_USE":
        print('istnieje');
        return "Istnieje już konto założone na podany adres email.";
      case "ERROR_TOO_MANY_REQUESTS":
        return "Spróbuj ponownie później.";
      case "ERROR_NETWORK_ERROR":
        return "Błąd połączenia.";
      case "ERROR_INVALID_EMAIL":
        return "Podany adres email jest nieprawidłowy.";
      case "ERROR_WRONG_PASSWORD":
        return "Nieprawidłowe hasło.";
      case "ERROR_USER_NOT_FOUND":
        return "Nie znaleziono użytkownika.";
      case "ERROR_WEAK_PASSWORD":
        return "Hasło musi się składać conajmniej z 6 znaków,";
      default:
        return "Wystąpił błąd";
    }
  }

  bool isResponseSuccessful(dynamic response) {
    if (response != null && response.runtimeType == String) {
      print(response.toString());
      errorMessage = mapResponseToErrorMessage(response);
      return false;
    } else if (response == null) {
      errorMessage = null;
      return false;
    } else {
      errorMessage = null;
      return true;
    }
  }
}
