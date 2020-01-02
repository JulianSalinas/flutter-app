import 'package:flutter/material.dart';
import 'package:letsattend/colors/ui_gradients.dart';
import 'package:letsattend/screens/schedule/date_page.dart';
import 'package:letsattend/screens/schedule/schedule.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/screens/news/news.dart';
import 'package:letsattend/providers/scheme.dart';


/// The theme is changed according to the variable available by the provider
class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<Scheme>(context);

    /// Allows to switch between dark and light mode
    final themeData = ThemeData(
      brightness: scheme.nightMode ? Brightness.dark : Brightness.light,
      primarySwatch: Colors.red,
      focusColor: Colors.white,
    );

    final routes = {
      '/': (context) => Schedule(),
    };

    final materialApp = MaterialApp(
        title: 'Let\'s Attend',
        routes: routes,
        theme: themeData
    );

    /// Renders the applications with the theme data
    return Material(child: materialApp);

  }
}
