import 'package:flutter/material.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:less_waste_app/core/viewmodels/home_model.dart';
import 'package:less_waste_app/ui/widgets/postlist_item.dart';
import 'package:provider/provider.dart';

import 'base_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
        onModelReady: (model) {
          model.getPosts(Provider.of<User>(context).id);
        },
        builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.pink,
            body: model.state == ViewState.Idle
                ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text('Welcome ${Provider.of<User>(context).name}',),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text('Here are all your posts'),
                  ),
                  Expanded(child: getPostsUi(model.posts)),
                ])
                : Center(child: CircularProgressIndicator())));
  }

  Widget getPostsUi(List<Post> posts) => ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) => PostListItem(
        post: posts[index],
        onTap: () {
          Navigator.pushNamed(context, 'post', arguments: posts[index]);
        },
      ));
}