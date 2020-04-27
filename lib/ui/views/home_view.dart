import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
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
    //final users = Provider.of<List<UserData>>(context);
    var posts = Provider.of<List<Post>>(context);
    var username;
    var userId = Provider.of<User>(context).id;

//    if(users != null) {
//      user = users.firstWhere((e) => e.id == Provider.of<User>(context).id);
//    }

    return StreamProvider<UserData>.value(
      value: DatabaseService().getCurrentUserById(userId),
      child: BaseView<HomeModel>(
        onModelReady: (model) {
          model.handleStartUpLogic();
        },
        builder: (context, model, child) => Scaffold(
            appBar: GradientAppBar(
                title: Text('Przeglądaj inspiracje'),
                gradient: LinearGradient(colors: [Colors.blue, Theme.of(context).primaryColor])
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, '/create_post');
              },
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      Provider.of<UserData>(context) != null && Provider.of<UserData>(context).username != null ? Provider.of<UserData>(context).username : "Profil",
                      //user.username,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.vpn_key, color: Colors.teal),
                    title: Text('Wyloguj się'),
                    onTap: () async {
                      Navigator.pop(context);
                      await model.logout();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.teal),
                    title: Text('Profil'),
                    onTap: () async {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.teal),
                    title: Text('Ustawienia'),
                    onTap: () async {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/settings');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.teal),
                    title: Text('O aplikacji'),
                    onTap: () async {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                ],
              ),
            ),
            // backgroundColor: Color(0xff5C892A),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[Expanded(child: getPostsUi(posts,

                       // users
                    ))],
                  )),
      ),
    );
  }

  Widget getPostsUi(
    List<Post> posts,
    //List<UserData> users,
  ) =>
      ListView.builder(
          itemCount: posts != null && posts.isNotEmpty ? posts.length : 0,
          itemBuilder: (context, index) => PostListItem(
                post: posts[index],
               // users: users,
                onTap: () {
                  Navigator.pushNamed(context, '/post', arguments: posts[index]);
                },
              ));
}
