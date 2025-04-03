import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_master/core/splash_master.dart';
import 'package:teachers_app/config/app.dart';
import 'package:teachers_app/core/provider/user_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SplashMaster.initialize();
   // Setup your config before the resume.
  SplashMaster.resume();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: MyApp(),) );
}

