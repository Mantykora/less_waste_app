import 'package:flutter/material.dart';
import 'package:less_waste_app/core/services/authentication_services.dart';
import 'package:less_waste_app/core/viewmodels/login_model.dart';
import 'package:less_waste_app/ui/widgets/login_header.dart';
import 'package:provider/provider.dart';
import '../../service_locator.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>.value(

      value: locator<LoginModel>(),

      child: Consumer<LoginModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.black38,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginHeader(
                controller: controller,
                validationMessage: model.errorMessage,
              ),
              FlatButton(
                  color: Colors.white,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    var loginSuccess = await model.login(controller.text);
                    if (loginSuccess) {
                      Navigator.pushNamed(context, '/');
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}