import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:letsattend/blocs/settings_bloc.dart';


/// A simple colored screen with a centered text
class HomeCircle extends StatelessWidget {

  final Icon icon;
  final Color color;
  final Function onTap;
  final String text;

  HomeCircle({
    @required this.icon,
    @required this.onTap,
    this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {

    final settings = Provider.of<SettingsBloc>(context);

    final borderSide = BorderSide(
      color: color ?? (settings.nightMode ? Colors.white38 : Colors.black45),
      width: 1.5,
    );

    final circleBorder = CircleBorder(
      side: borderSide
    );

    final button = FlatButton(
      color: Colors.transparent,
      child: icon,
      shape: circleBorder,
      padding: EdgeInsets.all(20),
      onPressed: onTap,
    );

    final buttonText = Text(
      text,
      style: TextStyle(fontSize: 10),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        button,
        SizedBox(height: 8),
        buttonText,
      ],
    );

  }

}
