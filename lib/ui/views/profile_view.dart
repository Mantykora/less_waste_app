import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:less_waste_app/core/enums/dialog_type.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:less_waste_app/core/models/user_data.dart';
import 'package:less_waste_app/core/viewmodels/profile_model.dart';
import 'package:less_waste_app/ui/widgets/profile_textfield.dart';
import 'package:provider/provider.dart';
import 'base_view.dart';

class ProfileView extends StatelessWidget {
  final  String profileUserId;
  ProfileView(this.profileUserId);


  @override
  Widget build(BuildContext context) {

    final currentUserId = Provider.of<User>(context).id;

    bool isThisUserMe;
    if (profileUserId != null) {
      isThisUserMe = false;
    } else {
      isThisUserMe = true;
    }

    final users = Provider.of<List<UserData>>(context);

    UserData user =
    isThisUserMe
    ? users.firstWhere((e) => e.id == currentUserId)
    : users.firstWhere((e) => e.id == profileUserId);

    final TextEditingController nameController = TextEditingController(text: user.name);
    final TextEditingController lastNameController = TextEditingController(text: user.lastName);
    final TextEditingController aboutMeController = TextEditingController(text: user.description);
    print(user.username);

    ImageSource imageSource;

    File choosenPhoto;

    bool isProfilePicFromServer = true;

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
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: ClipOval(
                                  child: InkWell(
                                    customBorder: CircleBorder(),
                                    onTap: () async {
                                      imageSource = await _choosePhoto(context);
                                      //TODO if imageSource != null
                                      if (imageSource != null) {
                                        File file = await ImagePicker.pickImage(source: imageSource);
                                        //TODO only square cropp
                                        await ImageCropper.cropImage(
                                            sourcePath: file.path,
                                            cropStyle: CropStyle.circle,
                                            aspectRatioPresets: [
                                              CropAspectRatioPreset.square,
                                            ],
                                            androidUiSettings: AndroidUiSettings(
                                                toolbarTitle: 'Przytnij zdjęcie',
                                                toolbarColor: Theme.of(context).primaryColor,
                                                toolbarWidgetColor: Colors.white,
                                                activeControlsWidgetColor: Theme.of(context).accentColor,
                                                initAspectRatio: CropAspectRatioPreset.original,
                                                lockAspectRatio: false),
                                            iosUiSettings: IOSUiSettings(
                                              minimumAspectRatio: 1.0,
                                            )).then((image) {
                                          isProfilePicFromServer = false;
                                          choosenPhoto = image;
                                          //model.uploadImage(image: image, userId: user.id);
                                          model.setState(ViewState.Idle);
                                        });
                                      }

                                    },
                                    child:
                                        //TODO remove photo
                                        //no photo is shown
                                        user.profilePhotoUrl == null && choosenPhoto == null
                                            ? Container(
                                                color: Colors.black38,
                                                width: 150,
                                                height: 150,
                                                child: Icon(
                                                  Icons.add_a_photo,
                                                  color: Colors.white,
                                                  size: 45,
                                                ),
                                              )
                                            //photo from the server
                                            : isProfilePicFromServer
                                                ? Container(
                                                    height: 150,
                                                    width: 150,
                                                    child: Image.network(
                                                      user.profilePhotoUrl,
                                                      width: 150,
                                                      height: 150,
                                                      fit: BoxFit.fill,
                                                    ))
                                                //photo chosen from the gallery/camera
                                                : Container(
                                                    height: 150,
                                                    width: 150,
                                                    child: Image.file(
                                                      choosenPhoto,
                                                      width: 150,
                                                      height: 150,
                                                      fit: BoxFit.fill,
                                                    )),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 75.0,
                                // alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {
                                    model.deleteImage(userId: user.id);
                                  },
                                  child: ClipOval(
                                    child: Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Theme.of(context).accentColor,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              SliverList(
                //itemExtent: 50.0,
                delegate: SliverChildListDelegate([
                  ProfileTextField(nameController, "imię", false, isThisUserMe),
                  ProfileTextField(lastNameController, "nazwisko", false, isThisUserMe),
                  ProfileTextField(aboutMeController, "o mnie", true, isThisUserMe),
                  Padding(
                    padding: const EdgeInsets.only(top: 54.0, right: 24.0, left: 24.0),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        color: Theme.of(context).accentColor,
                        child: Text("Zapisz"),
                        onPressed: () {
                          //upload profile photo, update user data

                          if (choosenPhoto != null) {
                            model.uploadImage(image: choosenPhoto, userId: user.id, name: nameController.text, lastName: lastNameController.text, description: aboutMeController.text);
                          } else {
                            model.updateUserById(userId: user.id, name: nameController.text, lastName: lastNameController.text, description: aboutMeController.text);
                          }
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
