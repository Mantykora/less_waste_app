import 'package:flutter/material.dart';
import 'package:less_waste_app/core/enums/post_type.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:less_waste_app/core/viewmodels/create_post_model.dart';
import 'package:provider/provider.dart';

import 'base_view.dart';

class CreatePostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user.id);

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
                  var addPost = model.addPostToDatabase(Post(userId: user.id, body: controller.text, category: _postType.index, commentsCount: 0, likesCount: 0));
                  if (addPost != null) {
                    Navigator.of(context).pop();
                  } else {
                    print('error');
                  }
                },
              ),
              // backgroundColor: Color(0xff5C892A),
              body: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      maxLines: 8,
                      controller: controller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Wybierz kategorię do której zalicza się Twój post:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ListTile(
                          title: Row(
                            children: <Widget>[
                              const Text('Żywność'),
                            ],
                          ),
                          leading: Radio(
                              value: PostType.food,
                              groupValue: _postType,
                              onChanged: (value) {
                                _postType = model.onRadioChange(_postType, value);
                              }),
                        ),
                        ListTile(
                          title: const Text('Środki czystości'),
                          leading: Radio(
                              value: PostType.cleaning,
                              groupValue: _postType,
                              onChanged: (
                                PostType value,
                              ) {
                                _postType = model.onRadioChange(_postType, value);
                              }),
                        ),
                        ListTile(
                          title: const Text('Uroda'),
                          leading: Radio(
                              value: PostType.beauty,
                              groupValue: _postType,
                              onChanged: (value) {
                                _postType = model.onRadioChange(_postType, value);
                              }),
                        ),
                        ListTile(
                          title: const Text('Ubrania'),
                          leading: Radio(
                              value: PostType.clothes,
                              groupValue: _postType,
                              onChanged: (value) {
                                _postType = model.onRadioChange(_postType, value);
                              }),
                        ),
                        ListTile(
                          title: const Text('Inne'),
                          leading: Radio(
                              value: PostType.others,
                              groupValue: _postType,
                              onChanged: (value) {
                                _postType = model.onRadioChange(_postType, value);
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
