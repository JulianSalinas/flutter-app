import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:letsattend/app.dart';
import 'package:letsattend/providers/auth.dart';
import 'package:letsattend/providers/scheme.dart';


void main() {

  /// Access variables at the top of the three
  /// by using the provider pattern
  /// [See] https://pub.dev/packages/provider
  final providers = [
    ChangeNotifierProvider<Auth>(create: (context) => Auth()),
    ChangeNotifierProvider<Scheme>(create: (context) => Scheme()),
  ];

  /// Entry point of the Flutter application
  runApp(MultiProvider(
    child: App(),
    providers: providers,
  ));

}
