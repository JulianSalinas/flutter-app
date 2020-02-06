import 'package:flutter/material.dart';

class DrawerBadge extends StatelessWidget {

  final String badge;

  const DrawerBadge(this.badge);

  @override
  Widget build(BuildContext context) {

    final badgeTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
    );

    final badgeText = Text(
      badge,
      style: badgeTextStyle,
    );

    final badgeDecoration = BoxDecoration(
      color: Colors.deepOrange,
      borderRadius: BorderRadius.circular(5.0),
    );

    final content = Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      alignment: Alignment.center,
      decoration: badgeDecoration,
      child: badgeText,
    );

    return Material(
      elevation: 5.0,
      color: Colors.deepOrange,
      shadowColor: Colors.red,
      borderRadius: BorderRadius.circular(5.0),
      child: content,
    );

  }

}
