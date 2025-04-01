import 'package:flutter/material.dart';
import 'package:teachers_app/utility/constants/colors.dart';

class MyTesxFiled extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  const MyTesxFiled({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: IKColors.primary, fontSize: 20),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: IKColors.primary,
              width: 2,
            ), // Adjusted width
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: IKColors.secondary,
              width: 3,
            ), // Adjusted width
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
