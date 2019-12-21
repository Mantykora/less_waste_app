import 'package:flutter/material.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/viewmodels/authenticate_model.dart';
import 'package:less_waste_app/ui/widgets/login_header.dart';
import 'package:provider/provider.dart';
import '../../service_locator.dart';
import 'base_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthenticateModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginHeader(
             validationMessage: model.errorMessage,
              loginController: _loginController,
              passController: _passController,
            ),
            model.state == ViewState.Busy
                ? CircularProgressIndicator()
                : FlatButton(
                    color: Colors.white,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      var loginSuccess = await model.login(_loginController.text, _passController.text);

                      if (loginSuccess != null) {
                        Navigator.pushNamed(context, '/home');
                      }
                    },
                  ),
            FlatButton(
              color: Colors.white,
              child: Text(
                'goToRegister',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
               model.toggleView();
              },
            )
          ],
        ),
      ),
    );
  }
}
