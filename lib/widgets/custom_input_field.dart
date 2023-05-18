import 'package:flutter/material.dart';
import 'package:tfg_flutter_app/theme/app_theme.dart';

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final String? helperText;
  final String? labelText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final String formProperty;
  final Map<String, String> formValues;
  const CustomInputField({
    Key? key,
    this.hintText,
    this.helperText,
    this.labelText,
    this.icon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    required this.formProperty,
    required this.formValues,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        autofocus: false,
        textCapitalization: TextCapitalization.words,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: (value) => formValues[formProperty] = value,
        // validator: (value) {
        //   if (value == null) return "Este campo es requerido";
        //   return value.length < 3 ? "Mínimo 3 letras" : null;
        // },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(
                    color: AppTheme.primary,
                    style: BorderStyle.solid,
                    width: 3)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppTheme.primary,
                    style: BorderStyle.solid,
                    width: 3)),
            hintText: hintText,
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black),
            helperText: helperText,
            //counterText: "3 caracteres"),
            //prefix: Icon(Icons.verified_user_outlined),
            suffixIcon: suffixIcon == null
                ? null
                : CircleAvatar(radius: 15, child: Icon(suffixIcon)),
            icon: icon == null
                ? null
                : CircleAvatar(
                    backgroundColor: AppTheme.primary,
                    radius: 28,
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 25,
                        foregroundColor: Colors.black,
                        child: Icon(
                          icon,
                          size: 30,
                        )),
                  )));
  }
}
