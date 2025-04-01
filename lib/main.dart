import 'package:flutter/material.dart';
import 'package:splash_master/core/splash_master.dart';
import 'package:teachers_app/config/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SplashMaster.initialize();
   // Setup your config before the resume.
  SplashMaster.resume();
  runApp(const MyApp());
}

