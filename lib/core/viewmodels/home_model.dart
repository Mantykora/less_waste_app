import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/services/api.dart';

import '../../service_locator.dart';
import 'base_model.dart';

class HomeModel extends BaseModel {
  Api _api = locator<Api>();
  List<Post> posts;
  Future getPosts(int userId) async {
    setState(ViewState.Busy);
    posts = await _api.getPostsForUser(userId);
    setState(ViewState.Idle);
  }
}