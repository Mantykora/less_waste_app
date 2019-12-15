import 'package:flutter/foundation.dart';
import 'package:less_waste_app/core/services/authentication_services.dart';

import '../../service_locator.dart';
/// Represents the state of the view
enum ViewState { Idle, Busy }
class LoginModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
  Future<bool> login(String userIdText) async {
    setState(ViewState.Busy);
    var userId = int.tryParse(userIdText);
    var success =  await _authenticationService.login(userId);
    setState(ViewState.Idle);
    return success;
  }


}