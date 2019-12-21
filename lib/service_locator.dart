import 'package:get_it/get_it.dart';

import 'core/services/api.dart';
import 'core/services/auth.dart';
import 'core/services/authentication_services.dart';
import 'core/viewmodels/authenticate_model.dart';
import 'core/viewmodels/comments_model.dart';
import 'core/viewmodels/home_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => AuthenticateModel());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => CommentsModel());


}