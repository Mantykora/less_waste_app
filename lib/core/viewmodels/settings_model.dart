import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_model.dart';

class SettingsModel extends BaseModel {
  final DatabaseService database = DatabaseService();
  FirebaseMessaging firebaseMessaging =  FirebaseMessaging();

  Future<void> notificationSettings(bool value) async {
    if (value) {
      firebaseMessaging.subscribeToTopic('News');
      await saveToSharedPrefs(value);
      print('subscribe to topic News');
      setState(ViewState.Idle);
    } else {
      await firebaseMessaging.unsubscribeFromTopic("News");
      saveToSharedPrefs(value);
      print('unsubscribe from topic News');
      setState(ViewState.Idle);
    }
  }

  void saveToSharedPrefs(bool isActive) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('news', isActive);
  }

  Future<bool> readFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isActive = prefs.getBool('news');
    setState(ViewState.Idle);
    return isActive;
  }

}

