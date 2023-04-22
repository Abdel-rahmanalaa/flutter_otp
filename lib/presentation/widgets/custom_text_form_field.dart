import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String? hintText;
  TextInputType? keyboardType;
  FormFieldValidator<String> validate;
  IconData? prefix;
  bool isPassword = false;
  CustomTextFormField({
    super.key,
    required this.controller,
    required this.validate,
    this.keyboardType,
    this.hintText,
    this.prefix,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: validate,
      decoration: _inputDecorationMethod(),
    );
  }

  _inputDecorationMethod() => InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(prefix),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey.shade500),
        ),
      );
}
