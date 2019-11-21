import 'package:flutter/material.dart';
import 'screens/home.dart';


void main() => runApp(GoTogether());

class GoTogether extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      home: HomeScreen(title: 'Go Together!'),
    );

}