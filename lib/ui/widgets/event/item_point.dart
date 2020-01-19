import 'package:flutter/material.dart';
import 'package:letsattend/core/services/theme_service.dart';
import 'package:provider/provider.dart';

class NestedPoint extends StatelessWidget {

  final bool isOdd;
  final Color color;

  NestedPoint({
    @required this.color,
    this.isOdd,
  });

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<ThemeService>(context);
    final evenColor = scheme.nightMode ? Colors.white : Colors.black;

    final innerDecoration = BoxDecoration(
      color: isOdd ? color : evenColor,
      shape: BoxShape.circle,
    );

    final innerPoint = Container(
      decoration: innerDecoration,
    );

    final outerDecoration = BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(width: 3, color: isOdd ? color: evenColor),
    );

    final content = Container(
      width: 20,
      height: 20,
      child: innerPoint,
      padding: EdgeInsets.all(4.5),
      decoration: outerDecoration,
    );

    return Opacity(
      opacity: isOdd ? 1 : 0.4,
      child: content,
    );

  }
}
