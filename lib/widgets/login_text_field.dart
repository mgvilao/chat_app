import 'package:chat_app/utils/textfield_styles.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool mustObscure;

  const LoginTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator,
      this.mustObscure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: mustObscure,
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: ThemeTextStyle.loginTextFieldStyle,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
