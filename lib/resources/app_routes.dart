import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp/controller/cubit/phone_Auth/cubit/phone_auth_cubit.dart';
import 'package:flutter_otp/presentation/screens/login_screen.dart';
import 'package:flutter_otp/presentation/screens/otp_screen.dart';
import 'package:flutter_otp/presentation/screens/verification_screen.dart';

class RoutesName {
  static const String loginRoute = "/loginRoute";
  static const String otpRoute = "/otpRoute";
  static const String verifyRoute = "/verifyRoute";
}

class AppRoutes {
  PhoneAuthCubit? phoneAuthCubit;

  AppRoutes() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generatePageRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.loginRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: LoginScreen(),
          ),
        );
      case RoutesName.otpRoute:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );
      case RoutesName.verifyRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: VerifyScreen(),
          ),
        );
    }
  }
}
