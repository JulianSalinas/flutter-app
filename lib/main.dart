import 'package:flutter/material.dart';
import 'package:letsattend/providers/auth.dart';
import 'package:letsattend/providers/scheme.dart';
import 'package:letsattend/screens/auth/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:letsattend/screens/schedule/sheet.dart';

void main() {

  /// Access variables at the top of the three
  /// by using the provider pattern
  /// [See] https://pub.dev/packages/provider
  final providers = [
    ChangeNotifierProvider<Auth>(builder: (context) => Auth()),
    ChangeNotifierProvider<Scheme>(builder: (context) => Scheme()),
  ];

  /// Entry point of the Flutter application
  runApp(MultiProvider(
    child: App(),
    providers: providers,
  ));

}

/// The theme is changed according to the variable available by the provider
class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<Scheme>(context);

    /// Allows to switch between dark and light mode
    final themeData = ThemeData(
      brightness: scheme.nightMode ? Brightness.dark : Brightness.light,
      primarySwatch: Colors.red,
    );

    /// TODO: Fix home screen
    /// App's main container
    //    final home = Sample(
    //      text: 'HOME',
    //      color: FlatUI.emerald,
    //    );

    final home = Sheet(date: DateTime.now(),);

    /// Renders the applications with the theme data
    return Material(
      child: MaterialApp(home: home, theme: themeData),
    );

  }
}
