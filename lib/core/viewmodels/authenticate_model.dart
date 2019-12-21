import 'package:flutter/foundation.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/services/auth.dart';
import 'package:less_waste_app/core/services/authentication_services.dart';

import '../../service_locator.dart';
import 'base_model.dart';
/// Represents the state of the view
class AuthenticateModel extends BaseModel {

  bool isSignInView = true;

  void toggleView() {
    setState(ViewState.Busy);
    isSignInView = !isSignInView;
    setState(ViewState.Idle);
  }


}