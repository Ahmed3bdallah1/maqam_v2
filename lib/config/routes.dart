import 'package:flutter/material.dart';
import 'package:maqam_v2/features/auth/presentation/view/login_screen.dart';
import 'package:maqam_v2/features/auth/presentation/view/sign_up.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String SignUpScreen = '/sign_up';
  static const String HomeScreen = '/home_screen';
  static const String DetalisScreen = '/details_screen';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => const LoginScreen(),
    SignUpScreen : (context) => const SignUp(),


  };
}
