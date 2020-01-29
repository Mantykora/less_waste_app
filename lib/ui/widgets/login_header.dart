import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  final TextEditingController loginController;
  final TextEditingController emailController;
  final TextEditingController passController;
  final String validationMessage;
  final bool isSignUp;
  final bool isForgot;

  LoginHeader({this.loginController,  @required this.emailController, @required this.passController, this.validationMessage, this.isSignUp, this.isForgot});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Icon(
          Icons.person_outline,
          color: Colors.white,
          size: 70,
        ),
      ),
      this.isSignUp != null ? LoginTextField(loginController, Icons.person_outline, 'login', false) : Container(),
      LoginTextField(emailController, Icons.email, 'e-mail', false),
      Visibility(
          visible: !isForgot,
          child: LoginTextField(passController, Icons.lock_outline, 'password', true)),
      this.validationMessage != null ? Text(validationMessage, style: TextStyle(color: Colors.red)) : Container()
    ]);
  }
}

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  IconData icon;
  String hint;
  bool isPass;

  LoginTextField(this.controller, this.icon, this.hint, this.isPass);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      height: 50.0,
      alignment: Alignment.centerLeft,
      child: TextField(
          obscureText: isPass,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(
              icon,
              color: Colors.white,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0, style: BorderStyle.solid),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0, style: BorderStyle.solid),
            ),
          ),
          // decoration: InputDecoration.collapsed(hintText: 'User Id'),
          controller: controller),
    );
  }
}
