import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:teachers_app/core/provider/user_provider.dart';
import 'package:teachers_app/screens/auth/login/components/gradient_text.dart';
import 'package:teachers_app/screens/auth/login/components/textfield.dart';
import 'package:teachers_app/utility/constants/colors.dart';
import 'package:teachers_app/utility/constants/images.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    bool success = await userProvider.login(
      context,
      emailController.text,
      passwordController.text,
    );

    if (success) {
      Navigator.pushReplacementNamed(context, "/home"); // Navigate to home
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Place Login Text on Top
            Padding(
              padding: const EdgeInsets.only(top: 50), // Adds space from top
              child: GradientText(
                text: "Namaste Guruji",
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20), // Space between "Login" text and the rest
            // Center the rest of the content
            Center(
              child: Column(
                children: [
                  Image.asset(IKImages.logo, height: screenHeight / 2.5),
                  SizedBox(height: 20),

                  // Email and Password TextFields
                  MyTesxFiled(
                    controller: emailController,
                    labelText: "Username",
                  ),
                  MyTesxFiled(
                    controller: passwordController,
                    labelText: "Password",
                  ),

                  // Login Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      height: screenHeight / 17,
                      child: ElevatedButton(
                        onPressed: () {
                          _login();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: IKColors.secondary,
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
