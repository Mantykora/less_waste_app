import 'dart:async';

import 'package:less_waste_app/core/viewmodels/login_model.dart';

import '../../service_locator.dart';
import 'api.dart';

class AuthenticationService {
  // Inject our Api
  Api _api = locator<Api>();
  Future<bool> login(int userId) async {
    // Get the user profile for id
    var fetcheduser = await _api.getUserProfile(userId);
// Check if success
    var hasUser = fetcheduser != null;
    print(fetcheduser.name);
    return hasUser;
  }

}