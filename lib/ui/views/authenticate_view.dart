import 'package:flutter/material.dart';
import 'package:less_waste_app/core/enums/viewstate.dart';
import 'package:less_waste_app/core/services/authentication_services.dart';
import 'package:less_waste_app/core/viewmodels/authenticate_model.dart';
import 'package:less_waste_app/ui/views/register_view.dart';
import 'package:less_waste_app/ui/widgets/login_header.dart';
import 'package:provider/provider.dart';
import '../../service_locator.dart';
import 'base_view.dart';
import 'login_view.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthenticateModel>(
      builder: (context, model, child) =>

      model.isSignInView
          ? LoginView()
          : RegisterView()

    );
  }
}
