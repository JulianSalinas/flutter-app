import 'package:flutter/material.dart';

class NestedPoint extends StatelessWidget {

  final Color color;

  NestedPoint({@required this.color});

  @override
  Widget build(BuildContext context) {

    final innerDecoration = BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    );

    final innerPoint = Container(
      decoration: innerDecoration,
    );

    final outerDecoration = BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(width: 3, color: color),
    );

    return Container(
      width: 20,
      height: 20,
      child: innerPoint,
      padding: EdgeInsets.all(4.5),
      decoration: outerDecoration,
    );

  }
}
