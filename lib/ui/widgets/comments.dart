import 'package:flutter/material.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/viewmodels/post_model.dart';
import 'package:less_waste_app/ui/views/base_view.dart';

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
                  )),
    );
  }
}

/// Renders a single comment given a comment model
class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({this.comment});

  @override
  Widget build(BuildContext context) {
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
          Text(comment.body, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
        ],
      ),
    );
  }
}
