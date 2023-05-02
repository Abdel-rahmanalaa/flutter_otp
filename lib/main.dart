import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp/app/app.dart';
import 'package:flutter_otp/app/dependency_injection.dart';
import 'config/routes/app_routes.dart';

late String initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initGetIt();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((user) => user == null
      ? initialRoute = RoutesName.loginRoute
      : initialRoute = RoutesName.verifyRoute);
  runApp(
    MyApp(
      appRoute: AppRoutes(),
    ),
  );
}
