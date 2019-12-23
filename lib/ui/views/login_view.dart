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
                  loginController: _loginController,
                  passController: _passController,
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
                          'Register',
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
                          'Forgot password',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          model.toggleView();
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
