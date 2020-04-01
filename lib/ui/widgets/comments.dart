import 'package:flutter/material.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:less_waste_app/core/utils/postTime.dart';
import 'package:less_waste_app/core/viewmodels/post_model.dart';
import 'package:less_waste_app/ui/views/base_view.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class Comments extends StatelessWidget {
  final String postId;
  final List<Comment> comments;

  Comments({this.postId, this.comments});

  @override
  Widget build(BuildContext context) {
    return BaseView<PostModel>(
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments != null && comments.isNotEmpty ? comments.length : 0,
              itemBuilder: (context, index) => CommentItem(
                    comment: comments[index],
                    model: model,
                  )),
    );
  }
}

/// Renders a single comment given a comment model
class CommentItem extends StatelessWidget {
  final Comment comment;
  final PostModel model;

  bool isThisUserMe = false;

  CommentItem({this.comment, this.model});

  @override
  Widget build(BuildContext context) {
    if (Provider.of<User>(context).id == comment.userId) {
      isThisUserMe = true;
    }

    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Color(0xff00AB5E)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          Text(
//            comment.name,
//            style: TextStyle(fontWeight: FontWeight.bold),
//          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                comment.body,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              isThisUserMe
                  ? IconButton(
                      icon: Icon(
                        Icons.more_horiz,
                      ),
                      onPressed: () {
                        _settingModalBottomSheet(context, model, comment, comment.postId);
                      },
                    )
                  : Container()
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              timeFromNow(comment.time),
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/profile', arguments: comment.userId);
              },
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/profile', arguments: comment.userId);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Text('autor:'),
                    comment.profilePhotoUrl != null
                        ? ClipOval(
                            child: Container(
                              child: Image.network(comment.profilePhotoUrl),
                              width: 30,
                              height: 30,
                            ),
                          )
                        : ClipOval(
                            child: Container(
                              color: Colors.black12,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              width: 40,
                              height: 40,
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        comment.userName,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _settingModalBottomSheet(context, PostModel model, Comment comment, String postId) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(leading: new Icon(Icons.edit), title: new Text('Edytuj'), onTap: () => {}),
              new ListTile(
                leading: new Icon(Icons.delete),
                title: new Text('Usuń'),
                onTap: () => {model.deleteComment(postId, comment)},
              ),
            ],
          ),
        );
      });
}
