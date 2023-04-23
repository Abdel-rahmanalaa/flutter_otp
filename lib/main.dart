import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'resources/app_routes.dart';

late String initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((user) => user == null
      ? initialRoute = RoutesName.loginRoute
      : initialRoute = RoutesName.verifyRoute);
  runApp(MyApp(
    appRoute: AppRoutes(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRoutes appRoute;

  const MyApp({super.key, required this.appRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: appRoute.generatePageRoute,
      initialRoute: initialRoute,
    );
  }
}
