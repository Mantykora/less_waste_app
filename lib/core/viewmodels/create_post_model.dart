import 'package:less_waste_app/core/enums/post_type.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/services/database.dart';
import 'base_model.dart';

class CreatePostModel extends BaseModel {
  final DatabaseService database = DatabaseService();

  Future addPostToDatabase(Post post) async {
    setState(ViewState.Busy);
    await database.updatePost(post).then((onValue) {
      print('post added to database');
    }).catchError((onError) {
      print('error adding post');
      return null;
    });

    setState(ViewState.Idle);
  }

  Future updatePostById(Post post, String body, int category) async {
    setState(ViewState.Busy);
    await database.updatePostById(
        id: post.id, count: post.likesCount, body: body, category: category);
  }

  PostType onRadioChange(PostType value, PostType second) {
    setState(ViewState.Busy);

    value = second;
    setState(ViewState.Idle);

    return value;
  }
}
