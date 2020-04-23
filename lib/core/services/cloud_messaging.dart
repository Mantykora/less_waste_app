
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:less_waste_app/core/models/post.dart';

import '../../main.dart';

class CloudMessagingService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        await _serialiseAndNavigate(message);
       // MyApp.navigatorKey.currentState.pushNamed("/about",);
       // _serialiseAndNavigate(message);

      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
       await _serialiseAndNavigate(message);
       // MyApp.navigatorKey.currentState.pushNamed("/about", );
        //Navigator.of(context).pushNamed(context, '/about');
       // _serialiseAndNavigate(message);
      },
    );
  }

//  'userId': post.userId,
//  'id': docdocUid,
//  'body': post.body,
//  'category': post.category,
//  'count': post.commentsCount,
//  'likesCount': post.likesCount,
//  'timeStamp': post.timeStamp,
//  'isEdited' : false

  Future  _serialiseAndNavigate(Map<String, dynamic> message) async {
    var notificationData = message['data'];
    var id = notificationData['id'];
    var body = notificationData['body'];
    var userId = notificationData['userId'];
    var category = int.parse(notificationData['category']);
    var commentsCount = int.parse(notificationData['count']);
    var likesCount = int.parse(notificationData['likesCount']);
    var timeStamp = int.parse(notificationData['timeStamp']);
    bool isEdited = notificationData['isEdited'] == "true";


    Post post = Post(userId: userId,
      id: id,
      body: body,
      category: category,
      commentsCount: commentsCount,
      likesCount: likesCount,
      timeStamp: timeStamp,
      isEdited: isEdited
    );
    print(userId);

    if (post != null) {
      MyApp.navigatorKey.currentState.pushNamed("/post", arguments: post);
    }

}}