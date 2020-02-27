import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:provider/provider.dart';

/// Custom input with an icon
class RoundedInput extends StatelessWidget {

  final bool obscureText;
  final bool multiline;

  final Widget leading;
  final String hintText;
  final String errorText;
  final Function onChanged;
  final TextInputType keyboardType;
  final TextEditingController controller;

  RoundedInput({
    this.leading,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.keyboardType,
    this.controller,
    this.multiline = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {

    SettingsBloc settings = Provider.of<SettingsBloc>(context);

    final color = settings.nightMode
        ? Theme.of(context).backgroundColor.withOpacity(0.3)
        : Theme.of(context).disabledColor.withOpacity(0.1);

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(style: BorderStyle.none),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(style: BorderStyle.solid, color: Colors.red),
    );

    final prefix = Padding(
      child: leading,
      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
    );

    final decoration = InputDecoration(
      filled: true,
      fillColor: color,
      focusedErrorBorder: errorBorder,
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border,
      prefixIcon: prefix,
      hintText: hintText,
      errorText: errorText,
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    );

    final textField = TextFormField(
      cursorColor: settings.nightMode ? Colors.white : Colors.black,
      minLines: 1,
      maxLines: multiline ? 3 : 1,
      decoration: decoration,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
    );


    return Container(
      child: textField,
//      decoration: BoxDecoration(
//        color: color,
//        borderRadius: BorderRadius.all(Radius.circular(64.0)),
//      ),
    );

  }

}