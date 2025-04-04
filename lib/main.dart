import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_master/core/splash_master.dart';
import 'package:LNP_Guru/config/app.dart';
import 'package:LNP_Guru/core/provider/user_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SplashMaster.initialize();
  // Setup your config before the resume.
  SplashMaster.resume();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MyApp(),
    ),
  );
}
