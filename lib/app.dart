import 'package:flutter/material.dart';
import 'package:letsattend/providers/scheme.dart';
import 'package:letsattend/screens/auth/sign_in.dart';
import 'package:letsattend/screens/auth/auth_form.dart';
import 'package:provider/provider.dart';

/// TODO: DELETE REFERENCE
//import 'file:///C:/Github/letsattend/test/sandbox.dart';

/// Here the home screen is set
/// The theme is changed according to the variable available by the provider
/// This view is directly inside [main.dart]
class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<Scheme>(context);

    /// Allows to switch between dark and light mode
    final themeData = ThemeData(
      brightness: scheme.darkMode ? Brightness.dark : Brightness.light,
      primarySwatch: Colors.red,
    );

    /// TODO: Fix home screen
    /// App's main container
    //    final home = Sample(
    //      text: 'HOME',
    //      color: FlatUI.emerald,
    //    );

    final home = Login();

    /// Renders the applications with the theme data
    return Material(
      child: MaterialApp(home: home, theme: themeData),
    );

  }
}
