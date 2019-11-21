import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() => runApp(LetsAttend());

class LetsAttend extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      home: HomeScreen(title: 'Go Together!'),
    );
  }

}