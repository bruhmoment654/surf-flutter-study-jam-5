import 'package:flutter/material.dart';

class OutlinedTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextStyle? style;

  const OutlinedTextFormField(
      {super.key,
      this.hintText = '',
      this.obscureText = false,
      required this.controller,
      this.validator,
      this.style});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.white)),
          hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
