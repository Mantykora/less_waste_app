import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/models/like.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:less_waste_app/core/models/user_data.dart';
import 'package:less_waste_app/core/services/database.dart';
import 'package:less_waste_app/core/utils/get_text_for_comments.dart';
import 'package:less_waste_app/core/viewmodels/post_model.dart';
import 'package:less_waste_app/ui/widgets/comments.dart';
import 'package:provider/provider.dart';
import 'base_view.dart';

class AboutAppView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: GradientAppBar(
          title: Text('Informacje o aplikacji'),
          gradient: LinearGradient(colors: [Colors.blue, Theme.of(context).primaryColor])
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text("Ikonki wykonane przez Freepik oraz Kiranshastry z www.flaticon.com")
          ],
        ),
      ),
    );
  }
}
