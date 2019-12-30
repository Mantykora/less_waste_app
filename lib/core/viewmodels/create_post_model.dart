import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/services/api.dart';
import 'package:less_waste_app/core/services/database.dart';

import '../../service_locator.dart';
import 'base_model.dart';

class CreatePostModel extends BaseModel {
  final DatabaseService database = DatabaseService();

  Future addPostToDatabase(Post post) async {
    setState(ViewState.Busy);
    await database.updatePost(post);
    setState(ViewState.Idle);
  }


}

