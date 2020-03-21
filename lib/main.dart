import 'package:flutter/material.dart';
import 'package:less_waste_app/service_locator.dart';
import 'package:less_waste_app/ui/router.dart';
import 'package:less_waste_app/ui/views/wrapper.dart';
import 'package:provider/provider.dart';
import 'core/models/post.dart';
import 'core/models/user.dart';
import 'core/models/user_data.dart';
import 'core/services/auth.dart';
import 'core/services/database.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          //initialData: User.initial(),
          value: locator<AuthService>().user,
        ),
        StreamProvider<List<UserData>>.value(
          value: DatabaseService().users,
        ),
        StreamProvider<List<Post>>.value(
          value: DatabaseService().posts,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xff00AB5E),

          //accentColor: Color(0xffD2932C),
            accentColor: Color(0xffFD4B2D),
        ),
        home: Wrapper(),
        initialRoute: '/wrapper',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
