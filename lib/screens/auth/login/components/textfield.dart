import 'package:flutter/material.dart';
import 'package:LNP_Guru/utility/constants/colors.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final bool iconShow; // Keep this final
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.iconShow,
    this.validator,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isObscure = true; // Moved inside State to toggle properly

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        validator: widget.validator,
        obscureText:
            widget.iconShow ? _isObscure : !_isObscure, // Use state variable
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: IKColors.primary, fontSize: 20),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: IKColors.primary, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: IKColors.secondary, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: IKColors.primary,
              width: 2,
            ), // Same as focused
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: IKColors.danger,
              width: 2,
            ), // Same as focused
          ),

          errorStyle: TextStyle(color: Colors.red),
          suffixIcon:
              widget.iconShow
                  ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure; // Toggle visibility correctly
                      });
                    },
                    icon: Icon(
                      _isObscure
                          ? Icons.visibility
                          : Icons.visibility_off, // Update icon dynamically
                    ),
                  )
                  : null,
        ),
      ),
    );
  }
}
