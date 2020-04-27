import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:less_waste_app/core/models/post.dart';
import 'package:less_waste_app/ui/views/about_app.dart';
import 'package:less_waste_app/ui/views/create_post_view.dart';
import 'package:less_waste_app/ui/views/home_view.dart';
import 'package:less_waste_app/ui/views/login_view.dart';
import 'package:less_waste_app/ui/views/post_view.dart';
import 'package:less_waste_app/ui/views/profile_view.dart';
import 'package:less_waste_app/ui/views/settings_view.dart';
import 'package:less_waste_app/ui/views/wrapper.dart';

const String initialRoute = "login";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/post':
        var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => PostView(post: post));
      case '/wrapper':
        return MaterialPageRoute(builder: (_) => Wrapper());
      case '/create_post':
        var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => CreatePostView(post: post));
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileView(settings.arguments));
      case '/about':
        return MaterialPageRoute(builder: (_) => AboutAppView());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
