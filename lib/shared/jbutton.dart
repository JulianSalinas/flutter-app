import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/theme/theme_text.dart';
import 'package:letsattend/providers/palette.dart';


class JButton extends StatelessWidget {

    final String text;
    final Widget icon;
    final Color color;
    final Function onPressed;

    JButton(this.text, {
        this.icon,
        this.color = FlatUI.emerald,
        @required this.onPressed
    });

    @override
    Widget build(BuildContext context) {

        final Palette palette = Provider.of<Palette>(context);
        final buttonIcon = icon != null ? icon : SizedBox.shrink();

        final buttonContent = [
            buttonIcon,
            SizedBox(width: icon == null ? 0 : 8),
            ThemeText(text, color: palette.darkMode ? Colors.white : color)
        ];

        final buttonRow = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttonContent
        );

        final buttonContainer = Container(
            height: 48,
            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: buttonRow
        );

        final buttonBorder = RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(24),
            side: BorderSide(color: color, width: 2),
        );

        final raiseButton = RaisedButton(
            color: color,
            shape: buttonBorder,
            child: buttonContainer,
            onPressed: this.onPressed,
        );

        final flatButton = FlatButton(
            shape: buttonBorder,
            child: buttonContainer,
            onPressed: this.onPressed,
        );

        return palette.darkMode ? raiseButton : flatButton;


    }

}