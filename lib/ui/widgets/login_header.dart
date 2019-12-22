import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final TextEditingController loginController;
  final TextEditingController passController;
  final String validationMessage;

  LoginHeader({@required this.loginController, @required this.passController,  this.validationMessage});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Login', style: TextStyle(color: Colors.white)),
      LoginTextField(loginController, Icons.person_outline, 'login'),
      LoginTextField(passController, Icons.lock_outline, 'password'),
      this.validationMessage != null
          ? Text(validationMessage, style: TextStyle(color: Colors.red))
          : Container()
    ]);
  }
}

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  IconData icon;
  String hint;

  LoginTextField(this.controller, this.icon, this.hint);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,

//      decoration: BoxDecoration(
//          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: TextField(

          cursorColor: Colors.white,
          decoration: InputDecoration(
         hintText: hint,
           hintStyle: TextStyle(color: Colors.white),
           // fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Colors.white,),

            focusedBorder: UnderlineInputBorder(

              borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                  style: BorderStyle.solid
              ),

            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.0,
                  style: BorderStyle.solid
              ),

            ),

          ),
         // decoration: InputDecoration.collapsed(hintText: 'User Id'),
          controller: controller),
    );
  }
}