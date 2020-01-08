import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/services/database.dart';

import 'base_model.dart';

class CommentsModel extends BaseModel {
  List<Comment> comments;
  final DatabaseService database = DatabaseService();

  Stream<List<Comment>> getComments(String postId) {
    setState(ViewState.Busy);
    database.getComments(postId);
    setState(ViewState.Idle);
  }
}
