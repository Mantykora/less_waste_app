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
    print(user.id);

    final users = Provider.of<List<UserData>>(context);

    return BaseView<HomeModel>(
      //onModelReady: (model) => model.getPosts(Provider.of<User>(context).id),
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
            onPressed: () {},
          ),
          //  backgroundColor: Color(0xff78A7F7),
          body: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Welcome ${users[0].username}',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(Provider.of<User>(context).id),
                    ),

                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Card(

                              color: Color(0x805C892A),
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  print('Card tapped.');
                                },
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: Colors.yellow,
                                    //  width: 300,
                                      height: 100,
                                ),
                                    Container(
                                      width: 300,
                                      height: 100,
//                                  child: Column(
//                                    crossAxisAlignment: CrossAxisAlignment.stretch,
//
//                                    children: <Widget>[
//                                     Container(
//                                       //constraints: BoxConstraints(m),
//                                       //width: 300,
//                                       height: 40,
//                                       color: Colors.red,
//                                     )
//                                    ],
//                                  ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),

                    Card(
                        color: Color(0x80E9D0A0),
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            print('Card tapped.');
                          },
                          child: Container(
                            width: 300,
                            height: 100,
                            child: Text('A card that can be tapped'),
                          ),
                        )),
                    Card(
                        color: Color(0x8078A7F7),
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            print('Card tapped.');
                          },
                          child: Container(
                            width: 300,
                            height: 100,
                            child: Text('A card that can be tapped'),
                          ),
                        ))

//                      Align(
//                        alignment: Alignment.bottomRight,
//                        child: FloatingActionButton(
//                          onPressed: () {},
//                        ),
//                      )
                    // Expanded(child: getPostsUi(model.posts)),
                  ],
                )),
    );
  }

  Widget getPostsUi(List<Post> posts) => ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) => PostListItem(
            post: posts[index],
            onTap: () {
              Navigator.pushNamed(context, '/post', arguments: posts[index]);
            },
          ));
}
