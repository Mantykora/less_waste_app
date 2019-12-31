import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:less_waste_app/core/enums/post_type.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:less_waste_app/core/models/user_data.dart';
import 'package:less_waste_app/core/services/database.dart';
import 'package:less_waste_app/core/viewmodels/create_post_model.dart';
import 'package:less_waste_app/core/viewmodels/home_model.dart';
import 'package:less_waste_app/ui/widgets/postlist_item.dart';
import 'package:provider/provider.dart';

import 'base_view.dart';

class CreatePostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user.id);

    final users = Provider.of<List<UserData>>(context);

    var posts = Provider.of<List<Post>>(context);

    TextEditingController controller = TextEditingController();

    PostType _postType = PostType.food;


    return BaseView<CreatePostModel>(
      //onModelReady: (model) => model.getPosts(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
            title: Text('Create a post'),
//            actions: <Widget>[
//              IconButton(
//                  onPressed: () async {
//                    await model.logout();
//                  },
//                  icon: Icon(Icons.vpn_key))
//            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.check),
            onPressed: () {
             // model.
              //model.addPostToDatabase(Post(userId: user.id, id: '5', body: 'bla', category: 3));
            },
          ),
          // backgroundColor: Color(0xff5C892A),
          body: Column(
            children: <Widget>[
              TextField(
                maxLines: 8,
                controller: controller,
              ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(

            children: <Widget>[
              Text('Wybierz kategorię do której zalicza się Twój post:', style: TextStyle(fontWeight: FontWeight.bold),),
              ListTile(
                title: const Text('Żywność'),
                leading: Radio(
                  value: PostType.food,
                  groupValue: _postType,
                  onChanged: (value) {
                    _postType = model.onRadioChange(_postType, value);
                  }
                ),
              ),
              ListTile(
                title: const Text('Środki czystości'),
                leading: Radio(
                  value: PostType.cleaning,
                  groupValue: _postType,
                  onChanged: (PostType value,) {
                    _postType = model.onRadioChange(_postType, value);
                  }
                ),
              ),
              ListTile(
                title: const Text('Uroda'),
                leading: Radio(
                    value: PostType.beauty,
                    groupValue: _postType,
                    onChanged: (value) {
                      _postType = model.onRadioChange(_postType, value);
                    }
                ),
              ),
              ListTile(
                title: const Text('Ubrania'),
                leading: Radio(
                    value: PostType.clothes,
                    groupValue: _postType,
                    onChanged: (value) {
                      _postType = model.onRadioChange(_postType, value);
                    }
                ),
              ),
              ListTile(
                title: const Text('Inne'),
                leading: Radio(
                    value: PostType.others,
                    groupValue: _postType,
                    onChanged: (value) {
                      _postType = model.onRadioChange(_postType, value);
                    }
                ),
              ),
            ],
          ),
        ),
            ],
          ),
    ));
  }

}
