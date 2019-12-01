import 'package:flutter/material.dart';
import 'package:letsattend/app.dart';
import 'package:letsattend/providers/auth.dart';
import 'package:letsattend/providers/scheme.dart';
import 'package:provider/provider.dart';

/// Entry point of the Flutter application
void main() => runApp(Main());

/// Wraps the application to get the ability to access
/// variables at the top of the three using the provider pattern
/// [See] https://pub.dev/packages/provider
class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    /// All global widgets must be here
    final providers = [
      ChangeNotifierProvider<Auth>(builder: (context) => Auth()),
      ChangeNotifierProvider<Scheme>(builder: (context) => Scheme()),
    ];

    /// Providers are available across the app
    return MultiProvider(providers: providers, child: App());

  }
}
