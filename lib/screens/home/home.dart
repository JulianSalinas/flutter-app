import 'package:flutter/material.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/screens/sample.dart';

class Home extends StatefulWidget {

  @override
  HomeState createState() => HomeState();

}

/// A simple colored screen with a centered text
class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {


    final temporal = Sample(
      color: FlatUI.greenSea,
      text: 'home',
    );

    return Scaffold(
      body: temporal,
      appBar: AppBar(
        title: Text('LET\'S ATTEND'),
      ),
    );

  }
}
