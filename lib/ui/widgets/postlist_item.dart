import 'package:flutter/material.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user_data.dart';
import 'package:less_waste_app/core/utils/get_text_for_comments.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final Function onTap;
  final List<UserData> users;

  final Function getUserData;

  PostListItem({this.post, this.users, this.getUserData, this.onTap});


  @override
  Widget build(BuildContext context) {

    List<String> categories = [ "Żywność", "Środki czystości", "Uroda", "Ubrania", "Inne" ];
    List assets = [Icons.fastfood, Icons.local_laundry_service, Icons.face, Icons.accessibility, Icons.autorenew];


    String user = users.firstWhere((e) => e.id == post.userId).username;
    print(user);

    print(users[0].id);
    print(post.userId.toString());

    return       Row(
      children: <Widget>[
        Expanded(
          child: Card(
            // color: Color(0x805C892A),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                      Text(
                           post.body),
                         // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(

                          children: <Widget>[Text('autor: '),

                            Text
                              (user),
                           ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("4"),
                            Icon(Icons.star_border),
                            Spacer(),
                            Text(post.commentsCount == null ? "" : post.commentsCount.toString()),
                            Text(getTextForCommentsCount(post.commentsCount))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ],
    );
  }
}


