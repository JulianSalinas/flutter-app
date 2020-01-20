import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:letsattend/colors.dart';

/// Custom input with an icon
class ModernInput extends StatelessWidget {

  final bool obscureText;

  final IconData icon;
  final String hintText;
  final String errorText;
  final Function onChanged;
  final TextInputType keyboardType;
  final TextEditingController controller;

  ModernInput({
    this.icon,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.keyboardType,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(color: FlatUI.midnightBlue, width: 2.0),
    );

    final prefix = Padding(
      child: Icon(icon),
      padding: const EdgeInsets.fromLTRB(24, 0, 12, 0),
    );

    final decoration = InputDecoration(
      border: border,
      prefixIcon: prefix,
      focusedBorder: border,
      hintText: hintText,
      errorText: errorText,
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    );

    return TextField(
      decoration: decoration,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
    );

  }

}