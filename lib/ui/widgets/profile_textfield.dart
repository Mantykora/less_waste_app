import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  String label;
  bool isLong;

  ProfileTextField(this.controller, this.label, this.isLong);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: TextField(
                  maxLines: isLong ? null : 1,
                  //style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: label,
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  // decoration: InputDecoration.collapsed(hintText: 'User Id'),
                  controller: controller),
          ),
        ),
      ],
    );

  }
}