import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:LNP_Guru/core/provider/user_provider.dart';
import 'package:LNP_Guru/screens/auth/login/components/gradient_text.dart';
import 'package:LNP_Guru/screens/auth/login/components/textfield.dart';
import 'package:LNP_Guru/utility/constants/colors.dart';
import 'package:LNP_Guru/utility/constants/images.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false; // Track loading state

  void _login() async {
    setState(() {
      isLoading = true; // Start loading
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    bool success = await userProvider.login(
      context,
      emailController.text,
      passwordController.text,
    );

    if (success) {
      Navigator.pushReplacementNamed(context, "/home"); // Navigate to home
    }

    setState(() {
      isLoading = false; // Stop loading
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: GradientText(
                text: "Namaste Guruji",
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Image.asset(IKImages.logo, height: screenHeight / 2.5),
                  SizedBox(height: 20),

                  MyTextField(
                    controller: emailController,
                    labelText: "Username",
                    iconShow: false,
                  ),
                  MyTextField(
                    controller: passwordController,
                    labelText: "Password",
                    iconShow: true,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      height: screenHeight / 17,
                      child: ElevatedButton(
                        onPressed:
                            isLoading ? null : _login, // Disable when loading
                        style: ElevatedButton.styleFrom(
                          backgroundColor: IKColors.secondary,
                        ),
                        child:
                            isLoading
                                ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    IKColors.primary,
                                  ),
                                )
                                : Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
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
