import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:movie_dovie/src/global/const/colors.dart';

class CustomTextField extends StatelessWidget {
  final Widget? suffixIcon;
  final bool obsureText;
  final String? initValue;
  final String? Function(String?)? onChanged;
  final TextEditingController? controller;
  final String text;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onSubmitted;
  CustomTextField({
    Key? key,
    this.onChanged,
    this.controller,
    required this.text,
    required this.textInputAction,
    required this.validator,
    this.onSubmitted,
    this.initValue,
    this.obsureText = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsureText,
      initialValue: initValue,
      onChanged: onChanged,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => validator!(value!),
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted,
      style: TextStyle(color: ConstantColor.buttonColorsOne),
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        disabledBorder: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
        hintText: text,
        fillColor: const Color(0xFFFFFFFF),
        hintStyle: TextStyle(
          fontSize: 14.rt,
          color: ConstantColor.buttonColorsTwo,
          fontWeight: FontWeight.w400,
        ),
      ),
      textAlign: TextAlign.start,
    );
  }
}
