import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user_data.dart';
import 'package:less_waste_app/core/services/api.dart';
import 'package:less_waste_app/core/services/auth.dart';
import 'package:less_waste_app/core/services/database.dart';

import '../../service_locator.dart';
import 'base_model.dart';

class HomeModel extends BaseModel {
 // Api _api = locator<Api>();
  List<Post> posts;

  final AuthService _authenticationService = locator<AuthService>();
  final DatabaseService database = DatabaseService();

 Stream<List<Post>> getPosts()  {
    setState(ViewState.Busy);
      database.posts;
    setState(ViewState.Idle);
  }

  Future logout() async {
    setState(ViewState.Busy);
    await _authenticationService.signOut();
    setState(ViewState.Idle);
  }

  Future addPostToDatabase(Post post) async {
    setState(ViewState.Busy);
    await database.updatePost(post);
    setState(ViewState.Idle);
  }

}
