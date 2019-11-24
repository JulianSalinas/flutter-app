import 'package:flutter/material.dart';
import 'package:letsattend/screens/login.dart';
import 'package:letsattend/providers/palette.dart';
import 'package:letsattend/colors/ui_gradients.dart';
import 'package:letsattend/theme/theme_switch.dart';
import 'package:provider/provider.dart';


class ThemeScreen extends StatelessWidget {

    final Widget child;

    ThemeScreen({@required this.child});

    @override
    Widget build(BuildContext context) {

        final Palette palette = Provider.of<Palette>(context);

        final themeSwitch = ThemeSwitch(
            value: palette.darkMode,
            onChanged: palette.onChangeDarkMode
        );

        final flexibleWidget = Expanded(
            child: child,
        );

        return Column(children: [flexibleWidget, themeSwitch]);

    }

}
