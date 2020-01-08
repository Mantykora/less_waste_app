import 'package:flutter/material.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/services/database.dart';
import 'package:less_waste_app/core/utils/get_text_for_comments.dart';
import 'package:less_waste_app/core/viewmodels/post_model.dart';
import 'package:less_waste_app/ui/widgets/comments.dart';
import 'base_view.dart';

class PostView extends StatelessWidget {
  final Post post;

  PostView({this.post});

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> categories = ["Żywność", "Środki czystości", "Uroda", "Ubrania", "Inne"];
    List assets = [Icons.fastfood, Icons.local_laundry_service, Icons.face, Icons.accessibility, Icons.autorenew];

    return StreamBuilder<Post>(
        stream: DatabaseService().getPostById(post.id),
        builder: (context, snapshot) {
          return BaseView<PostModel>(
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
                        Text('user'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("4"),
                        Icon(Icons.star_border),
                        Spacer(),
                        Text(snapshot.data.commentsCount == null ? "" : snapshot.data.commentsCount.toString()),
                        Text(getTextForCommentsCount(snapshot.data.commentsCount))
                      ],
                    ),
                  ),
                  TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          var success = model.addCommentToDatabase(Comment(body: _commentController.text), post.id, snapshot.data.commentsCount);
                          if (success != null) {
                            _commentController.clear();
                          }
                        },
                      ))),
                  getCommentsUI(post.id, DatabaseService().getComments(post.id))
                ]),
              ),
            ),
          );
        });
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
