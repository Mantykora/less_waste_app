import 'dart:io';

import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/models/like.dart';
import 'package:less_waste_app/core/services/database.dart';
import 'base_model.dart';

class ProfileModel extends BaseModel {
  final DatabaseService database = DatabaseService();

  Future updateUserById({String userId, String name, String lastName, String description, File image}) async {
    setState(ViewState.Busy);
    await database.updateUserById(id: userId, name: name, lastName: lastName, description: description);
    setState(ViewState.Idle);
  }

  Future uploadImage({File image, String userId, String name, String lastName, String description}) async {
    setState(ViewState.Busy);
    await database.uploadImage(image, userId).then((url) {
      database.updateUserById(id: userId, profilePhotoUrl: url,  name: name, lastName: lastName, description: description);
    });
    setState(ViewState.Idle);
  }

  Future deleteImage({String userId}) async {
    setState(ViewState.Busy);
    await database.deleteImage(userId).then((url) {
      database.updateUserById(id: userId, profilePhotoUrl: null);
    });
    setState(ViewState.Idle);
  }
}
