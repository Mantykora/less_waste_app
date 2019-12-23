import 'package:flutter/material.dart';
import 'package:less_waste_app/service_locator.dart';
import 'package:less_waste_app/ui/router.dart';
import 'package:less_waste_app/ui/views/login_view.dart';
import 'package:less_waste_app/ui/views/wrapper.dart';
import 'package:provider/provider.dart';

import 'core/models/user.dart';
import 'core/services/auth.dart';
import 'core/services/authentication_services.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      initialData: User.initial(),
      value: locator<AuthService>().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: Wrapper(),
        initialRoute: '/wrapper',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
