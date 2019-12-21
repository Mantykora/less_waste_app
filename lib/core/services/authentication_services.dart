import 'dart:async';

import 'package:less_waste_app/core/models/user.dart';

import '../../service_locator.dart';
import 'api.dart';

class AuthenticationService {
  // Inject our Api
  Api _api = locator<Api>();

  StreamController<User> userController = StreamController<User>();
  Future<bool> login(int userId) async {
    // Not real login, we'll just request the user profile
    var fetcheduser = await _api.getUserProfile(userId);
    var hasUser = fetcheduser != null;
    if (hasUser) {
      userController.add(fetcheduser);
    }
    return hasUser;
  }

}