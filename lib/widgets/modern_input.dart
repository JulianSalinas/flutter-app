import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/view_models/settings_model.dart';
import 'package:provider/provider.dart';

/// Custom input with an icon
class ModernInput extends StatelessWidget {

  final bool obscureText;
  final bool multiline;

  final Widget leading;
  final String hintText;
  final String errorText;
  final Function onChanged;
  final TextInputType keyboardType;
  final TextEditingController controller;

  ModernInput({
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

    SettingsModel settingsModel = Provider.of<SettingsModel>(context);

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(style: BorderStyle.none),
    );

    final prefix = Padding(
      child: leading,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
    );

    final decoration = InputDecoration(
      border: border,
      enabledBorder: border,
      disabledBorder: border,
      focusedBorder: border,
      prefixIcon: prefix,
      hintText: hintText,
      errorText: errorText,
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    );

    final textField = TextField(
      minLines: 1,
      maxLines: multiline ? 3 : 1,
      decoration: decoration,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
    );

    final color = settingsModel.nightMode
        ? Theme.of(context).backgroundColor.withOpacity(0.3)
        : Theme.of(context).disabledColor.withOpacity(0.1);

    return Container(
      child: textField,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(64.0)),
      ),
    );

  }

}