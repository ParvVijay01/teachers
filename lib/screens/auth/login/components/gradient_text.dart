import 'package:flutter/material.dart';
import 'package:LNP_Guru/utility/constants/colors.dart';

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
