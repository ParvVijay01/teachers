import 'package:flutter/material.dart';

class IKColors {
  IKColors._();
  static const Color primary = Color(0xff211951);
  static const Color secondary = Color(0xff836FFF);
  static const Color danger = Color(0xFFEB5757);
  static const Color success = Color(0xFF219653);
  static const Color warning = Color(0xFFCC9108);
  static const Color light = Color(0xFFF4F4F4);
  static const Color dark = Color(0xFF0C101C);

  //light theme const
  static const Color background = Color.fromARGB(255, 223, 228, 249);
  static const Color card = Color.fromARGB(255, 177, 204, 255);
  static const Color title = Color.fromARGB(255, 0, 0, 0);
  static const Color text = Color(0xFF7D899D);
  static const Color border = Color(0xFFE6E6E6);

  // New colors for ShaderMask
  static const Color deepPurple = Color(0xFF5D2F8E); // Dark purple
  static const Color teal = Color(0xFF00796B); // Teal color
  static const Color softPink = Color(0xFFFFA7C4); // Soft pink
  static const Color lightPurple = Color(0xFFC1A4FF); // Light purple
  static const Color darkBlue = Color(0xFF001F3D); // Dark blue
  static const Color lightBlue = Color(0xFF4F8CFF); // Light blue
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const GradientText({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => LinearGradient(
            colors: [
              IKColors.primary,
              IKColors.secondary,
            ], // Using custom deep purple and teal
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
      child: Text(
        text,
        style: style.copyWith(
          color: Colors.white,
        ), // Text color is ignored due to ShaderMask
        textAlign: TextAlign.center,
      ),
    );
  }
}
