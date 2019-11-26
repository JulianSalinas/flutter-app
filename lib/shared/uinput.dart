import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UInput extends StatefulWidget {

    final Widget icon;
    final String hintText;
    final bool obscureText;
    final Function onChanged;
    final TextEditingController controller;

    UInput({
        this.icon,
        this.hintText,
        this.obscureText,
        this.onChanged,
        this.controller
    });

    @override
    UInputState createState() => UInputState();

}

class UInputState extends State<UInput>{

    @override
    Widget build(BuildContext context) {

        final inputBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0)
        );

        final inputPrefix = Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 12, 0),
            child: widget.icon,
        );

        final inputDecoration = InputDecoration(
            border: inputBorder,
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: widget.hintText,
            prefixIcon: inputPrefix
        );

        return TextField(
            obscureText: widget.obscureText,
            decoration: inputDecoration,
            onChanged: widget.onChanged,
            controller: widget.controller,
        );

    }

}