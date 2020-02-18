import 'package:flutter/material.dart';
import 'package:less_waste_app/core/models/like.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:less_waste_app/core/models/user_data.dart';
import 'package:less_waste_app/core/services/database.dart';
import 'package:less_waste_app/core/utils/get_text_for_comments.dart';
import 'package:less_waste_app/core/viewmodels/post_model.dart';
import 'package:less_waste_app/ui/views/base_view.dart';
import 'package:provider/provider.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final Function onTap;
  final List<UserData> users;

  final Function getUserData;

  PostListItem({this.post, this.users, this.getUserData, this.onTap});

  @override
  Widget build(BuildContext context) {
    List<String> categories = ["Żywność", "Środki czystości", "Uroda", "Ubrania", "Inne"];
    List assets = ['assets/watermelon.png', 'assets/spray.png', 'assets/makeup.png', 'assets/dress.png', 'assets/idea.png'];

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
        builder: (context, model, child) => Row(
          children: <Widget>[
            Expanded(
              child: Card(
                child: InkWell(
                  onTap: onTap,
                  //() {  Navigator.pushNamed(context, '/post', arguments: post);},
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Container(
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 8.0, bottom: 8.0),
                                child: Image.asset(assets[post.category]),
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
                      (post.body.length > 100) ? Text("${post.body.substring(0, 100)}...") : Text(post.body),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/profile', arguments: post.userId);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                             // Text('autor:'),
                              user.profilePhotoUrl != null
                              ? ClipOval(
                                child: Container(
                                    child: Image.network(user.profilePhotoUrl),
                                   width: 40,
                                  height: 40,
                                ),
                              )
                              : Container(),
                              //TODO 1 inkwell na całość
                               Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      user.username,
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                                    ),
                                  ),
                            ],
                          ),
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
                                      Provider.of<Post>(context).likesCount);
                                }
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(Provider.of<Post>(context) != null && Provider.of<Post>(context).likesCount != null ? Provider.of<Post>(context).likesCount.toString() : "0"),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Image.asset(Provider.of<List<Like>>(context) != null && Provider.of<List<Like>>(context).isNotEmpty ?  "assets/fern_full.png" : "assets/fern_empty.png"),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Text(
                              Provider.of<Post>(context) == null || Provider.of<Post>(context).commentsCount == null ? "" : Provider.of<Post>(context).commentsCount.toString(),
                            ),
                            Text(getTextForCommentsCount(Provider.of<Post>(context) == null ? 0 : Provider.of<Post>(context).commentsCount))
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
