import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:less_waste_app/core/models/user_data.dart';
import 'package:less_waste_app/core/viewmodels/post_model.dart';
import 'package:provider/provider.dart';
import 'base_view.dart';

class ProfileView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final currentUserId = Provider
        .of<User>(context)
        .id;
    final users = Provider.of<List<UserData>>(context);
    UserData user = users.firstWhere((e) => e.id == currentUserId);

    print(user.username);

    return BaseView<PostModel>(
      // onModelReady: (model) { comments =  model.getComments(post.id); },
      builder: (context, model, child) =>
          Scaffold(
            appBar: AppBar(
              title: Text('Me'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  children: <Widget>[
                  Text(user.username),
              ],


            ),
          ),
    ),);
  }
}
