import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:less_waste_app/core/viewmodels/settings_model.dart';
import 'package:less_waste_app/ui/views/base_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FirebaseMessaging firebaseMessaging =  FirebaseMessaging();
    bool isNotficationOn = true;

    return BaseView<SettingsModel>(
      onModelReady: (model) async {
        isNotficationOn = await model.readFromSharedPrefs();

      } ,
        builder: (context, model, child) => Scaffold(
          appBar: GradientAppBar(title: Text('Flutter'), gradient: LinearGradient(colors: [Colors.blue, Theme.of(context).primaryColor])),
          body: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Switch(onChanged: (bool value) {
                    isNotficationOn = value;
                    model.notificationSettings(isNotficationOn);
                  }, value: isNotficationOn,),
                  Text('Powiadomienia w aplikacji')
                ],
              )
            ],
          ),
        ),

    );
  }

  Future<bool> readFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isActive = prefs.getBool('news');
    return isActive;
  }
}