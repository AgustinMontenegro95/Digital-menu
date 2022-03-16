import 'package:digital_menu/screens/home_screen/home_screen.dart';
import 'package:digital_menu/screens/intro_screen/intro_login_screen.dart';
import 'package:digital_menu/screens/intro_screen/intro_screen.dart';
import 'package:digital_menu/screens/signin_screen/sign_in_screen.dart';
import 'package:digital_menu/screens/signup_screen/sign_up_screen.dart';
import 'package:digital_menu/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'splash': (_) => const SplashScreen(route: ""),
  'intro': (_) => const IntroScreen(),
  'introLogin': (_) => const IntroLoginScreen(),
  'signin': (_) => const SignInScreen(),
  'signup': (_) => const SignUpScreen(),
  //colocar home
  'home': (_) => const HomeScreen(),
};
