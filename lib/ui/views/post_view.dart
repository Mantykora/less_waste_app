import 'package:flutter/material.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:provider/provider.dart';

import 'comments_view.dart';

class PostView extends StatelessWidget {
  final Post post;
  PostView({this.post});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text(post.title,),
            Text(
              'by ${Provider.of<User>(context).name}',
              style: TextStyle(fontSize: 9.0),
            ),

            Text(post.body),
            Comments(post.id)
          ],
        ),
      ),
    );
  }
}