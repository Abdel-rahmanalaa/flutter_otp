import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp/config/locale/app_localizations_setup.dart';
import 'package:flutter_otp/main.dart';
import 'package:flutter_otp/config/routes/app_routes.dart';
import 'package:flutter_otp/presentation/controller/locale/cubit/locale_cubit.dart';
import 'dependency_injection.dart' as di;

class MyApp extends StatelessWidget {
  final AppRoutes appRoute;

  const MyApp({super.key, required this.appRoute});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => di.getIt<LocaleCubit>()..getSavedLang()),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          buildWhen: (perviousState, currentState) =>
              perviousState != currentState,
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: state.locale,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              onGenerateRoute: appRoute.generatePageRoute,
              initialRoute: initialRoute,
              supportedLocales: AppLocalizationsSetup.supportedLocales,
              localeResolutionCallback:
                  AppLocalizationsSetup.localeResolutionCallback,
              localizationsDelegates:
                  AppLocalizationsSetup.localizationsDelegates,
            );
          },
        ));
  }
}
