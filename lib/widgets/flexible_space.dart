import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:letsattend/view_models/theme_model.dart';

class FlexibleSpace extends StatelessWidget {

  const FlexibleSpace({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final themeModel = Provider.of<ThemeModel>(context);

    final backdrop = ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(color: Colors.black.withOpacity(0)),
      ),
    );

    final gradient = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.red, Colors.deepOrange],
        ),
      ),
    );

    return themeModel.nightMode ? backdrop : gradient;

  }

}
