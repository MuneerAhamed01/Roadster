import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_ster/application/splash_screen/splashscreen_cubit.dart';
import 'package:road_ster/presentation/onboarding_screens/onboarding_1.dart';
import 'package:road_ster/presentation/splash_screen/splash_screen.dart';

import '../Login_singnup/login_form/login_page.dart';

class AppRoutes {
  Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => SplashscreenCubit(),
                  child: const SplashScreen(),
                ));
      case "onboarding":
        return MaterialPageRoute(builder: (context) => const OnboardingOne());
         case "login":
        return MaterialPageRoute(builder: (context) =>  LoginPage());
      default:
        return MaterialPageRoute(builder: (context) => const OnboardingOne());
    }
  }
}
