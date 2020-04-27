import 'package:get_it/get_it.dart';
import 'package:less_waste_app/core/services/cloud_messaging.dart';
import 'package:less_waste_app/core/viewmodels/settings_model.dart';
import 'core/services/auth.dart';
import 'core/viewmodels/authenticate_model.dart';
import 'core/viewmodels/comments_model.dart';
import 'core/viewmodels/create_post_model.dart';
import 'core/viewmodels/home_model.dart';
import 'core/viewmodels/post_model.dart';
import 'core/viewmodels/profile_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => AuthenticateModel());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => CommentsModel());
  locator.registerFactory(() => CreatePostModel());
  locator.registerFactory(() => PostModel());
  locator.registerFactory(() => ProfileModel());
  locator.registerFactory(() => SettingsModel());
  locator.registerLazySingleton(() => CloudMessagingService());

}
