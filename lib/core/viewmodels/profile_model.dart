import 'dart:io';

import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/models/comment.dart';
import 'package:less_waste_app/core/models/like.dart';
import 'package:less_waste_app/core/services/database.dart';
import 'base_model.dart';

class ProfileModel extends BaseModel {
  final DatabaseService database = DatabaseService();

  Future updateUserById({String userId, String name, String lastName, String description, String profilePhotoUrl}) async {
    await database.updateUserById(id: userId, name: name, lastName: lastName, description: description, profilePhotoUrl: profilePhotoUrl);
  }

  Future uploadImage({File image, String userId}) async {
   await database.uploadImage(image).then((url) {
     updateUserById(userId: userId, profilePhotoUrl: url);
   });
  }

}
