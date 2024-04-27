import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final int maxLines;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const CustomTextField(
      {super.key,
      this.maxLines=1,
      required this.hintText,
       this.obscureText=false,
      required this.controller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
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
