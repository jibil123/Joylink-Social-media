import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:const TextStyle(
          color: Color.fromARGB(255, 188, 176, 176),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:const BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:const BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}
