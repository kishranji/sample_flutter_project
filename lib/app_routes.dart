import 'package:animation_rive/pages/change_password.dart';
import 'package:animation_rive/pages/forgot_password.dart';
import 'package:animation_rive/pages/login.dart';
import 'package:animation_rive/pages/sign_up.dart';
import 'package:flutter/material.dart';
class AppRoutes {
  static Map<String, WidgetBuilder> appRoutes(BuildContext context) {
    return {
      LoginPage.routeName: (BuildContext context) => LoginPage(),
      SignUpPage.routeName: (BuildContext context) => SignUpPage(),
      ForgotPassword.routeName: (BuildContext context) => ForgotPassword()
    };
  }
}