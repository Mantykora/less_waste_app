import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/services/database.dart';

import 'base_model.dart';

class SettingsModel extends BaseModel {
  final DatabaseService database = DatabaseService();
  FirebaseMessaging firebaseMessaging =  FirebaseMessaging();

  void notificationSettings(bool value) {
    if (value) {
      firebaseMessaging.subscribeToTopic('News');
      print('subscribe to topic News');
      setState(ViewState.Idle);
    } else {
      firebaseMessaging.unsubscribeFromTopic("News");
      print('unsubscribe from topic News');
      setState(ViewState.Idle);
    }
  }

}
