import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:less_waste_app/core/models/user.dart';

import 'database.dart';

class AuthService {
  AuthService({
    this.firebaseAuth,
   });

   FirebaseAuth firebaseAuth = FirebaseAuth.instance;



  //StreamController<User> userController = StreamController<User>();

  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(id: user.uid) : null;
  }

  Stream<User> get user {
     if (firebaseAuth == null ) {
       return null;
     }
    return firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebase(user));
  }

  Future signIn(String email, String password) async {
    try {
      AuthResult result = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      print(user.uid);
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

  Future signOut() async {
    try {
      return await firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future register(String login, String email, String password) async {
    try {
      AuthResult result;
      result = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
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

  Future remindPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);

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
