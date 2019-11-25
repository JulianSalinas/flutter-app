import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UInput extends StatelessWidget {

    final Widget icon;
    final String hintText;
    final bool obscureText;

    UInput({
        this.icon,
        this.hintText,
        this.obscureText
    });

    @override
    Widget build(BuildContext context) {

        final InputBorder inputBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0)
        );

        final Padding inputPrefix = Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 12, 0),
            child: icon,
        );

        final InputDecoration inputDecoration = InputDecoration(
            border: inputBorder,
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: hintText,
            prefixIcon: inputPrefix
        );

        return TextField(
            obscureText: obscureText,
            decoration: inputDecoration
        );

    }

}