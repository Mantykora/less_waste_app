import 'package:flutter/material.dart';
import 'package:less_waste_app/service_locator.dart';
import 'package:less_waste_app/ui/router.dart';
import 'package:less_waste_app/ui/views/login_view.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: LoginView(),
      onGenerateRoute: Router.generateRoute,
    );
  }
}
