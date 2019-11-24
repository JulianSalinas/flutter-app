import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/theme/theme_text.dart';


class ThemeSwitch extends StatelessWidget {

    final bool value;
    final Function onChanged;

    final String text;
    final Color color;

    ThemeSwitch({
        @required this.value,
        @required this.onChanged,
        this.color,
        this.text = 'MODO OSCURO'
    });

    Widget build(BuildContext context) {

        final switchComponent = CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: FlatUI.pomegranate,
        );

        final switchContent = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ThemeText(text), switchComponent]
        );

        return Container(
            child: switchContent,
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            decoration: BoxDecoration(color: color)
        );

    }

}

