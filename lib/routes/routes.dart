import 'package:LNP_Guru/screens/modulespdf/module.dart';
import 'package:flutter/material.dart';
import 'package:LNP_Guru/screens/auth/login/login.dart';
import 'package:LNP_Guru/screens/auth/onboarding/onboarding_screen.dart';
import 'package:LNP_Guru/screens/home/fillform/fill_form.dart';
import 'package:LNP_Guru/screens/home/homeScreen/home_screen.dart';
import 'package:LNP_Guru/screens/noticeBox/notice_box.dart';
import 'package:LNP_Guru/screens/profile/profile.dart';
import 'package:LNP_Guru/screens/reports/report.dart';
import 'package:LNP_Guru/screens/tutorials/tutorials.dart';

class AppRoutes {
  static const String home = '/home';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String fillform = '/fillform';
  static const String noticeBox = '/noticebox';
  static const String tutorials = '/tutorials';
  static const String profile = '/profile';
  static const String report = '/report';
  static const String module = '/module';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

      case login:
        return MaterialPageRoute(builder: (_) => Login());

      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case fillform:
        return MaterialPageRoute(builder: (_) => FillForm());

      case noticeBox:
        return MaterialPageRoute(builder: (_) => NoticeBox());

      case tutorials:
        return MaterialPageRoute(builder: (_) => Tutorials());

      case profile:
        return MaterialPageRoute(builder: (_) => Profile());

      case report:
        return MaterialPageRoute(builder: (_) => ReportScreen());

      case module:
        return MaterialPageRoute(builder: (_) => Modules());

      default:
        return _errorRoute("Page not found!");
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: Center(
              child: Text(message, style: const TextStyle(fontSize: 18)),
            ),
          ),
    );
  }
}
