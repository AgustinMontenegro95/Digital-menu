import 'dart:ffi';

import 'package:digital_menu/styles/app_colors.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String headingText;
  final String hintText;
  final bool obsecureText;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final TextEditingController controller;
  final String? Function(String?) funcion;
  final void Function(String)? onchange;
  final TextCapitalization textCapitalization;
  final FocusNode focusNode;
  final void Function()? onEditingComplete;

  const CustomFormField(
      {Key? key,
      required this.headingText,
      required this.hintText,
      required this.obsecureText,
      required this.suffixIcon,
      required this.textInputType,
      required this.controller,
      required this.funcion,
      required this.textCapitalization,
      required this.focusNode,
      required this.onEditingComplete,
      this.onchange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        onEditingComplete: onEditingComplete,
        focusNode: focusNode,
        textCapitalization: textCapitalization,
        keyboardType: textInputType,
        decoration: InputDecoration(
          icon: suffixIcon,
          hintText: hintText,
          labelText: headingText,
        ),
        controller: controller,
        obscureText: obsecureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: funcion,
        onChanged: onchange,
      ),
    );
  }
}
