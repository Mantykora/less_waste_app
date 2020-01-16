import 'package:flutter/material.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:less_waste_app/core/models/user_data.dart';
import 'package:less_waste_app/core/viewmodels/profile_model.dart';
import 'package:less_waste_app/ui/widgets/profile_textfield.dart';
import 'package:provider/provider.dart';
import 'base_view.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUserId = Provider.of<User>(context).id;
    final users = Provider.of<List<UserData>>(context);
    UserData user = users.firstWhere((e) => e.id == currentUserId);

    final TextEditingController nameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController aboutMeController = TextEditingController();

    print(user.username);

    return BaseView<ProfileModel>(
        builder: (context, model, child) => Scaffold(
                body: CustomScrollView(slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(user.username),
                ),
              ),
              SliverList(
                //itemExtent: 50.0,
                delegate: SliverChildListDelegate(
                    [ProfileTextField(nameController, "imię", false), ProfileTextField(lastNameController, "nazwisko", false), ProfileTextField(aboutMeController, "o mnie", true)]),
              )
            ])));
  }
}
