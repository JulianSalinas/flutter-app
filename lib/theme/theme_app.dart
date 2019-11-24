import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/providers/palette.dart';
import 'package:letsattend/theme/theme_screen.dart';


class ThemeApp extends StatelessWidget {

    final Widget startWidget;

    ThemeApp(this.startWidget);

    @override
    Widget build(BuildContext context) {

        Palette palette = Provider.of<Palette>(context);
        final mode = palette.darkMode ? 0 : 1;

        ThemeData themeData = ThemeData(
            brightness: Brightness.values[mode],
            primarySwatch: Colors.red,
        );

        return MaterialApp(
            home: Scaffold(
                body: ThemeScreen(startWidget)
            ),
            theme: themeData
        );

    }

}