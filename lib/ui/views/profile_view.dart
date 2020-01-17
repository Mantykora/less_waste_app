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

    final TextEditingController nameController = TextEditingController(text: user.name);
    final TextEditingController lastNameController = TextEditingController(text: user.lastName);
    final TextEditingController aboutMeController = TextEditingController(text: user.description);
    print(user.username);

    return BaseView<ProfileModel>(
        builder: (context, model, child) => Scaffold(
                body: CustomScrollView(slivers: <Widget>[
                  SliverAppBar(
                    stretch: true,
                    onStretchTrigger: () {
                      // Function callback for stretch
                      return;
                    },
                    expandedHeight: 300.0,
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: <StretchMode>[
                        StretchMode.zoomBackground,
                        StretchMode.blurBackground,
                        StretchMode.fadeTitle,
                      ],
                      centerTitle: true,
                      title: const Text('Flight Report'),
                      background: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(top: 16.0),
                              padding: EdgeInsets.only(left: 32.0, right: 32.0),
                              child: ClipOval(
                                child: Container(
                                  color: Colors.red,
                                  width: 150,
                                  height: 150,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
              SliverList(
                //itemExtent: 50.0,
                delegate: SliverChildListDelegate(
                    [
                      ProfileTextField(nameController, "imię", false),
                      ProfileTextField(lastNameController, "nazwisko", false),
                      ProfileTextField(aboutMeController, "o mnie", true),
                      Padding(
                        padding: const EdgeInsets.only(top: 54.0, right: 24.0, left: 24.0),
                        child:  RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),

                              ),
                              color: Theme.of(context).accentColor,
                              child: Text("Aktualizuj"),
                              onPressed: () {
                             model.updateUserById(userId: user.id, name: nameController.text, lastName: lastNameController.text, description: aboutMeController.text );
                          }

                          ),

                      )
                    ]
                ),
              )
            ])));
  }
}
