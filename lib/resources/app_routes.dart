import 'package:flutter/material.dart';
import 'package:flutter_otp/presentation/screens/login_screen.dart';

class RoutesName {
  static const String loginRoute = "/";
}

class AppRoutes {
  Route? generatePageRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
    }
  }
}
