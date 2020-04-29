import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:less_waste_app/core/viewmodels/settings_model.dart';
import 'package:less_waste_app/ui/views/base_view.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FirebaseMessaging firebaseMessaging =  FirebaseMessaging();
    bool isNotficationOn = true;

    return BaseView<SettingsModel>(
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

}