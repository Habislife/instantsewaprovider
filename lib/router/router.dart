import 'package:flutter/material.dart';
import 'package:provider/router/route_constants.dart';
import 'package:provider/ui/Auth/login_page.dart';
import 'package:provider/ui/Auth/signup_page.dart';
import 'package:provider/ui/not_found_page_views.dart';
import 'package:provider/ui/profile_page.dart';

class Routers {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signUpRoute:
        return MaterialPageRoute(builder: (_) => SignupPage());
      case profileRoute:
        return MaterialPageRoute(builder: (_) => ProfilePage());
        default:
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }
}
