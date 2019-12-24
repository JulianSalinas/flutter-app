import 'package:flutter/material.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/providers/auth.dart';
import 'package:letsattend/providers/scheme.dart';
import 'package:letsattend/screen.dart';
import 'package:letsattend/screens/detail/detail.dart';
import 'package:provider/provider.dart';
import 'package:letsattend/screens/schedule/date_page.dart';

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

    final test = DatePage(
      date: DateTime.now(),
    );

    final home = Scaffold(
      body: Screen(
        child: test
      ),
    );

    /// Renders the applications with the theme data
    return Material(
      child: MaterialApp(home: home, theme: themeData),
    );

  }
}
