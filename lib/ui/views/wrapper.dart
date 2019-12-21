import 'package:flutter/cupertino.dart';
import 'package:less_waste_app/core/models/user.dart';
import 'package:provider/provider.dart';

import 'authenticate_view.dart';
import 'home_view.dart';
import 'login_view.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final user = Provider.of<User>(context);



   if (user == null) {
     return Authenticate();
   } else {
     return HomeView();
   }

  }


}

