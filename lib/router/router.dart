import 'package:flutter/material.dart';
import 'package:provider/router/route_constants.dart';
import 'package:provider/ui/Auth/login_page.dart';
import 'package:provider/ui/Auth/signup_page.dart';
import 'package:provider/ui/home_page.dart';
import 'package:provider/ui/not_found_page_views.dart';
import 'package:provider/ui/otp_page.dart';
import 'package:provider/ui/profile_page.dart';
import 'package:provider/ui/user_address_page.dart';
import 'package:provider/ui/user_info_page.dart';
import 'package:provider/ui/user_phone_page.dart';

import '../ui/categories_list_page.dart';
import '../ui/track_order_page.dart';
class Routers {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
       case homeRoute:
         return MaterialPageRoute(builder: (_) => HomePage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case signUpRoute:
        return MaterialPageRoute(builder: (_) => SignupPage());
      case fullNameUpdateRoute:
        return MaterialPageRoute(builder: (_) => UserInfoPage());
      case phoneUpdateRoute:
        return MaterialPageRoute(builder: (_) => UserPhonePage());
    case profileRoute:
       return MaterialPageRoute(builder: (_) => ProfilePage());
      case addressUpdateRoute:
        return MaterialPageRoute(builder: (_)=>UserAddressPage());
       case trackerRoute:
         return MaterialPageRoute(builder: (_) => TrackOrder());
      case serviceSelectionRoute:
        return MaterialPageRoute(builder: (_) => AllCategoryList());
      case otpRoute:
        return MaterialPageRoute(builder: (_) => OtpPage());
      default:
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }
}
