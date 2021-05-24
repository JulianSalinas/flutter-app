import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A simple colored screen with a centered text
class HomeOption extends StatelessWidget {

  final Icon icon;
  final Color color;
  final GestureTapCallback? onTap;


  HomeOption({
    required this.icon,
    required this.onTap,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {

    final borderRadius = BorderRadius.all(Radius.circular(8.0));

    final content = Container(
      padding: EdgeInsets.all(20),
      child: icon,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
    );

    final inkWell = InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: content,
    );

    return Material(
      color: color,
      elevation: 16.0,
      borderRadius: borderRadius,
      borderOnForeground: true,
      child: inkWell,
    );

  }


}
