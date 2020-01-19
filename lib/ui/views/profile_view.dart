import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:less_waste_app/core/enums/dialog_type.dart';
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

    ImageSource imageSource;

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
                  title: Text(user.username),
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 16.0),
                          padding: EdgeInsets.only(left: 32.0, right: 32.0),
                          child: ClipOval(
                            child: InkWell(
                              customBorder: CircleBorder(),
                              onTap: () async {
                                imageSource = await _choosePhoto(context);
                                ImagePicker.pickImage(source: imageSource);
                              },
                              child: Container(
                                color: Colors.black38,
                                width: 150,
                                height: 150,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                  size: 45,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              SliverList(
                //itemExtent: 50.0,
                delegate: SliverChildListDelegate([
                  ProfileTextField(nameController, "imię", false),
                  ProfileTextField(lastNameController, "nazwisko", false),
                  ProfileTextField(aboutMeController, "o mnie", true),
                  Padding(
                    padding: const EdgeInsets.only(top: 54.0, right: 24.0, left: 24.0),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        color: Theme.of(context).accentColor,
                        child: Text("Aktualizuj"),
                        onPressed: () {
                          model.updateUserById(userId: user.id, name: nameController.text, lastName: lastNameController.text, description: aboutMeController.text);
                        }),
                  )
                ]),
              )
            ])));
  }
}

Future<ImageSource> _choosePhoto(BuildContext context) async {
  switch (await showDialog<DialogType>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Dodaj zdjęcie:'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, DialogType.camera);
              },
              child: const Text('Z aparatu'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, DialogType.gallery);
              },
              child: const Text('Z galerii'),
            ),
          ],
        );
      })) {
    case DialogType.camera:
      return ImageSource.camera;
      break;
    case DialogType.gallery:
      return ImageSource.gallery;
      break;
  }
}
