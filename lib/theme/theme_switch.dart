import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
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

        final switchDescription = [
            Icon(MaterialCommunityIcons.weather_night),
            SizedBox(width: 16),
            ThemeText(text)
        ];

        final switchContent = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Row(children: switchDescription), switchComponent]
        );

        return Hero(
            tag: 'theme-switch',
            child: Container(
                height: 48,
                child: switchContent,
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                decoration: BoxDecoration(color: color)
            )
        );

    }

}

