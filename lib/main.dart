import 'package:LNP_Guru/config/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:LNP_Guru/core/provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userProvider = UserProvider();
  await userProvider.tryAutoLogin(); // Call this before runApp

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => userProvider),
      ],
      child: const MyApp(), // Wrapped App
    ),
  );
}
