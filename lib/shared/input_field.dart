import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          contentPadding: const EdgeInsets.all(8)),
        
    );
  }
}
