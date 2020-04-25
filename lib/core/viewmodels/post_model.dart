import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/models/like.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/services/database.dart';
import 'base_model.dart';

class PostModel extends BaseModel {
  final DatabaseService database = DatabaseService();

  Future addCommentToDatabase(Comment comment, String postId, int postCount, String postBody, int category, bool isEdited) async {
    setState(ViewState.Busy);
    await database.updateComment(comment, postId).then((onValue) {
      print('comment added to database');

      updatePostById(postId, postCount == null ? 1 : postCount + 1, postBody, category, isEdited);
    }).catchError((onError) {
      print('error adding comment');
      return null;
    });
    setState(ViewState.Idle);
  }

  Future updatePostById(String postId, int count, String postBody, int category, bool isEdited) async {
    await database.updatePostById(id: postId, count: count, body: postBody, category: category, isEdited: isEdited);
  }

  Future updatePostLikeById(String postId, int likesCount) async {
    await database.updateLikesCountPostById(postId, likesCount);
  }

  Future deletePost(Post post) async {
    await database.deletePost(post);
  }

  Stream<List<Comment>> getComments(String postId) {
    setState(ViewState.Busy);
    database.getComments(postId);
    setState(ViewState.Idle);
  }

  Future deleteComment(String postId, Comment comment) async {
    await database.deleteComment(postId: postId, comment: comment);
  }

  Future updateLike(Like like, String postId, int likesCount) async {
    await database.updateLikes(like, postId);
    print(likesCount.toString());
    updatePostLikeById(postId, likesCount == null ? 1 : likesCount + 1);

  }

  Stream<List<Like>> getUserLikeForPost( String postId, String userId) {
    database.getUserLikeForPost(postId, userId);
  }

  Future deleteLike(String likeId, String postId, int likesCount) async {
    await database.deleteLike(likeId, postId);
    print(likesCount.toString());
    if (likesCount > 0) {
      updatePostLikeById(postId, likesCount == null || likesCount == 1 ? 0 : likesCount - 1);
    }
  }


}
