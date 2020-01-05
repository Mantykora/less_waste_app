import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:less_waste_app/core/models/user_data.dart';
import 'package:less_waste_app/core/services/database.dart';
import 'package:less_waste_app/core/viewmodels/home_model.dart';
import 'package:less_waste_app/ui/widgets/postlist_item.dart';
import 'package:provider/provider.dart';

import 'base_view.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final users = Provider.of<List<UserData>>(context);

    var posts = Provider.of<List<Post>>(context);

    return BaseView<HomeModel>(
      onModelReady: (model) => model.getPosts(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            actions: <Widget>[
              IconButton(
                  onPressed: () async {
                    await model.logout();
                  },
                  icon: Icon(Icons.vpn_key))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/create_post');
            },
          ),
          // backgroundColor: Color(0xff5C892A),
          body: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.only(left: 20.0),
//                      child: Text(
//                        'Welcome ${users[0].username}',
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(left: 20.0),
//                      child: Text(Provider.of<User>(context).id),
//                    ),


                     Expanded(child: getPostsUi(posts, users))
                  ],
                )),
    );
  }

  Widget getPostsUi(List<Post> posts, List<UserData> users, ) => ListView.builder(
      itemCount: posts != null && posts.isNotEmpty ? posts.length : 0,
      itemBuilder: (context, index) => PostListItem(
        post: posts[index],
        users: users,

        onTap: () {
              Navigator.pushNamed(context, '/post', arguments: posts[index]);
        },
      )

  );
}
