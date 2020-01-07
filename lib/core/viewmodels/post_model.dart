import 'package:less_waste_app/core/enums/post_type.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/services/api.dart';
import 'package:less_waste_app/core/services/database.dart';

import '../../service_locator.dart';
import 'base_model.dart';

class PostModel extends BaseModel {
  final DatabaseService database = DatabaseService();

  Future addCommentToDatabase(Comment comment, String postId) async {
    setState(ViewState.Busy);
    await database.updateComment(comment, postId).then((onValue) {
      print('comment added to database');
    }).catchError((onError) {
      print('error adding comment');
      return null;
    });
    setState(ViewState.Idle);
  }


  Stream<List<Comment>> getComments(String postId)  {
    setState(ViewState.Busy);
    database.getComments(postId);
    setState(ViewState.Idle);
  }
}
