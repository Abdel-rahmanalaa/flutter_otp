import 'package:flutter/material.dart';
import 'package:flutter_otp/presentation/screens/login_screen.dart';
import 'package:flutter_otp/presentation/screens/otp_screen.dart';

class RoutesName {
  static const String loginRoute = "/";
  static const String otpRoute = "/otpRoute";
}

class AppRoutes {
  Route? generatePageRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case RoutesName.otpRoute:
        return MaterialPageRoute(
          builder: (_) => OtpScreen(),
        );
    }
  }
}
