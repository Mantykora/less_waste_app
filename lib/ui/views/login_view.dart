
import 'package:flutter/material.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/viewmodels/authenticate_model.dart';
import 'package:less_waste_app/ui/widgets/login_header.dart';
import 'base_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BaseView<AuthenticateModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.blueAccent,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Opacity(
              child: Image.asset(
                'assets/background.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              opacity: 0.3,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LoginHeader(
                  validationMessage: model.errorMessage,
                  emailController: _emailController,
                  passController: _passController,
                  isForgot: model.isForgotView,
                ),
                model.state == ViewState.Busy
                    ? Padding(
                        padding: const EdgeInsets.all(27.0),
                        child: CircularProgressIndicator(),
                      )
                    : Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 50.0),
                              child: Container(
                                height: 40,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(18.0),
                                  ),
                                  color: Colors.white,
                                  child: Text(
                                    model.isForgotView
                                    ? 'Resetuj hasło'
                                    : 'Login',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () async {
                                    if(model.isForgotView) {
                                      var forgotSuccess = await model.remindPassword(_emailController.text);

                                      if(forgotSuccess != null) {
                                        print('forgot success');
                                        _showAlertDialog(context);

                                      }
                                    } else {
                                      var loginSuccess = await model.login(_emailController.text, _passController.text);

                                      if (loginSuccess != null) {
                                        Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
                                      }
                                    }

                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        //color: Colors.white,
                        child: Text(
                          'Rejestracja',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          model.toggleView();
                        },
                      ),
                      Text(
                        '|',
                        style: TextStyle(color: Colors.white),
                      ),
                      FlatButton(
                        //color: Colors.white,
                        child: Text(
                          model.isForgotView
                          ? 'Login'
                          : 'Resetuj hasło',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          model.toggleForgot();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}


Future<void> _showAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Link został wysłany."),
        content: Text("Link do zresetowania hasła został wysłany na Twoje konto email."),
        actions: <Widget>[
          FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      );
    },
  );
}