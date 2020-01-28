import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:less_waste_app/core/models/user.dart';

import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //StreamController<User> userController = StreamController<User>();

  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(id: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebase(user));
  }

  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      print(user.uid);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future register(String login, String email, String password) async {
    try {
      AuthResult result;
      result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      print(result.toString());
      print(user.uid);
      await DatabaseService(userId: user.uid).updateUserData(login);

      return user;
    } on PlatformException catch(e) {
      print(e.code);
      return(e.code);
    }

    catch (e) {
      print(e.toString());
      return null;
    }
  }
}
