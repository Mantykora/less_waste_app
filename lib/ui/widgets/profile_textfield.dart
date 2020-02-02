import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  String label;
  bool isLong;
  bool isThisUserMe;

  ProfileTextField(this.controller, this.label, this.isLong, this.isThisUserMe);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child:
            isThisUserMe
            ? TextField(
                  maxLines: isLong ? null : 1,
                  //style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: label,
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  // decoration: InputDecoration.collapsed(hintText: 'User Id'),
                  controller: controller)
                : Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(controller.text, style: TextStyle(fontSize: 17),),
                )
          ),
        ),
      ],
    );

  }
}