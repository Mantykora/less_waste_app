import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/viewmodels/comments_model.dart';
import 'package:less_waste_app/ui/widgets/comments.dart';

import 'base_view.dart';

class Comments extends StatelessWidget {
  final int postId;
  Comments(this.postId);
  @override
  Widget build(BuildContext context) {
    return BaseView<CommentsModel>(
        onModelReady: (model) => model.fetchComments(postId),
        builder: (context, model, child) => model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Expanded(child: ListView(
          children: model.comments
              .map((comment) => CommentItem(comment))
              .toList(),
        )));
  }
}