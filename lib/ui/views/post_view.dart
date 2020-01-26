import 'package:flutter/material.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/models/like.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:less_waste_app/core/models/user_data.dart';
import 'package:less_waste_app/core/services/database.dart';
import 'package:less_waste_app/core/utils/get_text_for_comments.dart';
import 'package:less_waste_app/core/viewmodels/post_model.dart';
import 'package:less_waste_app/ui/widgets/comments.dart';
import 'package:provider/provider.dart';
import 'base_view.dart';

class PostView extends StatelessWidget {
  final Post post;

  PostView({this.post});

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> categories = ["Żywność", "Środki czystości", "Uroda", "Ubrania", "Inne"];
    List assets = [Icons.fastfood, Icons.local_laundry_service, Icons.face, Icons.accessibility, Icons.autorenew];

    final users = Provider.of<List<UserData>>(context);
    UserData user = users.firstWhere((e) => e.id == post.userId);

    return MultiProvider(
        providers: [
          StreamProvider<Post>.value(
            value: DatabaseService().getPostById(post.id),
          ),
          StreamProvider<List<Like>>.value(
              value: DatabaseService().getUserLikeForPost(
            post.id,
            Provider.of<User>(context).id,
          ))
        ],
        child: BaseView<PostModel>(
          // onModelReady: (model) { comments =  model.getComments(post.id); },
          builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text('Post'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                Container(
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                          child: Icon(assets[post.category]),
                        ),
                        Text(
                          categories[post.category],
                          //'Żywność',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(post.body),
                // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text('autor: '),
                      Text(user.username),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          if (Provider.of<List<Like>>(context) != null && Provider.of<List<Like>>(context).isNotEmpty) {
                            String likeId = Provider.of<List<Like>>(context).first.id;
                            print(likeId);
                            model.deleteLike(likeId, post.id, Provider.of<Post>(context).likesCount);
                          } else {
                            model.updateLike(
                                Like(
                                  userId: Provider.of<User>(context).id,
                                  postId: post.id,
                                ),
                                post.id,
                                Provider.of<Post>(context).likesCount
                             );
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            Text(Provider.of<Post>(context) != null && Provider.of<Post>(context).likesCount != null ? Provider.of<Post>(context).likesCount.toString() : "0"),
                            Icon(Provider.of<List<Like>>(context) != null && Provider.of<List<Like>>(context).isNotEmpty ? Icons.star : Icons.star_border),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        Provider.of<Post>(context) == null || Provider.of<Post>(context).commentsCount == null ? "" : Provider.of<Post>(context).commentsCount.toString(),
                      ),
                       Text(getTextForCommentsCount( Provider.of<Post>(context) == null ? 0 : Provider.of<Post>(context).commentsCount))
                    ],
                  ),
                ),
                TextField(
                  maxLines: null,
                    controller: _commentController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        var success = model.addCommentToDatabase(Comment(body: _commentController.text), post.id, Provider.of<Post>(context).commentsCount);
                        if (success != null) {
                          _commentController.clear();
                        }
                      },
                    ))),
                getCommentsUI(post.id, DatabaseService().getComments(post.id))
              ]),
            ),
          ),
        ));
  }
}

Widget getCommentsUI(String postId, Stream stream) {
  return StreamBuilder<List<Comment>>(
    stream: stream,
    builder: (context, snapshot) {
      return Comments(
        postId: postId,
        comments: snapshot.data,
      );
    },
  );
}
