import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/models/like.dart';
import 'package:less_waste_app/core/services/database.dart';
import 'base_model.dart';

class PostModel extends BaseModel {
  final DatabaseService database = DatabaseService();

  Future addCommentToDatabase(Comment comment, String postId, int postCount) async {
    setState(ViewState.Busy);
    await database.updateComment(comment, postId).then((onValue) {
      print('comment added to database');

      updatePostById(postId, postCount == null ? 1 : postCount + 1);
    }).catchError((onError) {
      print('error adding comment');
      return null;
    });
    setState(ViewState.Idle);
  }

  Future updatePostById(String postId, int count) async {
    await database.updatePostById(postId, count);
  }

  Stream<List<Comment>> getComments(String postId) {
    setState(ViewState.Busy);
    database.getComments(postId);
    setState(ViewState.Idle);
  }

  Future updateLike(Like like, String postId) async {
    await database.updateLikes(like, postId);
  }

  Stream<List<Like>> getUserLikeForPost( String postId, String userId) {
    database.getUserLikeForPost(postId, userId);
  }


}
