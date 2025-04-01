import 'package:flutter/material.dart';
import 'package:teachers_app/screens/auth/login/login.dart';
import 'package:teachers_app/screens/auth/onboarding/onboarding_screen.dart';
import 'package:teachers_app/screens/home/home_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      
      case onBoarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

      case login:
        return MaterialPageRoute(builder: (_) => Login());
    
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());


      default:
        return _errorRoute("Page not found!");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: Center(child: Text(message, style: const TextStyle(fontSize: 18))),
      ),
    );
  }
}
