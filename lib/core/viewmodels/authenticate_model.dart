import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/services/auth.dart';

import '../../service_locator.dart';
import 'base_model.dart';

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

    var response = await _authenticationService.signIn(email, password);

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

    if (response == null) {
      errorMessage = null;
      setState(ViewState.Idle);
      return null;
    }

    isSignInView = true;
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
    } else if (password.length < 5) {
      errorMessage = 'Password must contain at least 5 characters';
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
