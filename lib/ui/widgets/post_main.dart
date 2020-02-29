import 'package:flutter/material.dart';
import 'package:less_waste_app/core/models/like.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:less_waste_app/core/models/user_data.dart';
import 'package:less_waste_app/core/utils/get_text_for_comments.dart';
import 'package:less_waste_app/core/viewmodels/post_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PostMain extends StatefulWidget {
  final String image;
  final String text;
  final Post post;
  final UserData user;
  final PostModel model;

  PostMain({this.image, this.text, this.post, this.user, this.model});

  @override
  _PostMainState createState() => _PostMainState();
}

class _PostMainState extends State<PostMain> {
  @override
  Widget build(BuildContext context) {
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                  child: Image.asset(widget.image),
                ),
                Text(
                  widget.text,
                  //'Żywność',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Text(widget.post.body),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
              timeFromNow(widget.post.timeStamp), style: TextStyle(fontSize: 12),),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/profile', arguments: widget.post.userId);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Text('autor:'),
                widget.user.profilePhotoUrl != null
                    ? ClipOval(
                  child: Container(
                    child: Image.network(widget.user.profilePhotoUrl),
                    width: 40,
                    height: 40,
                  ),
                )
                    :  ClipOval(
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
                    widget.user.username,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (Provider.of<List<Like>>(context) != null && Provider.of<List<Like>>(context).isNotEmpty) {
                    String likeId = Provider.of<List<Like>>(context).first.id;
                    print(likeId);
                    widget.model.deleteLike(likeId, widget.post.id, Provider.of<Post>(context).likesCount);
                  } else {
                    widget.model.updateLike(
                        Like(
                          userId: Provider.of<User>(context).id,
                          postId: widget.post.id,
                        ),
                        widget.post.id,
                        Provider.of<Post>(context).likesCount);
                  }
                },
                child: Row(
                  children: <Widget>[
                    Text(Provider.of<Post>(context) != null && Provider.of<Post>(context).likesCount != null ? Provider.of<Post>(context).likesCount.toString() : "0"),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Image.asset(Provider.of<List<Like>>(context) != null && Provider.of<List<Like>>(context).isNotEmpty ? "assets/fern_full.png" : "assets/fern_empty.png"),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                Provider.of<Post>(context) == null || Provider.of<Post>(context).commentsCount == null ? "" : Provider.of<Post>(context).commentsCount.toString(),
              ),
              Text(getTextForCommentsCount(Provider.of<Post>(context) == null ? 0 : Provider.of<Post>(context).commentsCount))
            ],
          ),
        ),
      ],
    );
  }
}

String timeFromNow(int postTime) {

  DateTime postTimeDate = DateTime.fromMillisecondsSinceEpoch(postTime);

  DateTime now = DateTime.now();
  var difference = now.difference(postTimeDate);

  if (difference < Duration(minutes: 1)) {
    return "przed chwilą";
  }
  else if  (difference < Duration(minutes: 60)){
    return "${difference.inMinutes} min";
  } else if (difference < Duration(hours: 24)) {
    return "${difference.inHours} h";
  } else return
    DateFormat("dd MMMM o HH:mm ").format(postTimeDate);

  //return difference.inSeconds;
}