import 'package:flutter/material.dart';
import 'package:less_waste_app/core/models/like.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:less_waste_app/core/models/user_data.dart';
import 'package:less_waste_app/core/services/database.dart';
import 'package:less_waste_app/core/utils/get_text_for_comments.dart';
import 'package:less_waste_app/core/viewmodels/post_model.dart';
import 'package:less_waste_app/ui/views/base_view.dart';
import 'package:less_waste_app/ui/widgets/post_main.dart';
import 'package:provider/provider.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final Function onTap;
  //final List<UserData> users;

  final Function getUserData;

  PostListItem({this.post,
    //this.users,
    this.getUserData, this.onTap});

  @override
  Widget build(BuildContext context) {
    List<String> categories = ["Żywność", "Środki czystości", "Uroda", "Ubrania", "Inne"];
    List assets = ['assets/watermelon.png', 'assets/spray.png', 'assets/makeup.png', 'assets/dress.png', 'assets/idea.png'];

    //final users = Provider.of<List<UserData>>(context);

    UserData user;
//    if (post != null && post.userId != null) {
//      user = users.firstWhere((e) => e.id == post.userId);
//    }

    //user = DatabaseService().ge

    //user = DatabaseService().getCurrentUserById(post.id);



    return MultiProvider(
      providers: [
        StreamProvider<Post>.value(
          value: post.id != null ? DatabaseService().getPostById(post.id) : null,
          catchError: (_, err) => Post()
        ),
        StreamProvider<List<Like>>.value(
            value: DatabaseService().getUserLikeForPost(
          post.id,
          Provider.of<User>(context).id,
        )),
        StreamProvider<UserData>.value(value: DatabaseService().getCurrentUserById(post.userId),
            catchError: (_, err) => null
        )
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
                    child:  PostMain(
                      image: assets[post.category],
                      text: categories[post.category],
                      post: post,
                      user: Provider.of<UserData>(context),
                      model: model,
                    ),
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
