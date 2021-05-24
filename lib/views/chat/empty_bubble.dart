import 'dart:math';
import 'package:flutter/material.dart';
import 'package:letsattend/widgets/animation/shimmer.dart';

class EmptyBubble extends StatelessWidget {

  final bool isOwned;
  EmptyBubble(this.isOwned);

  @override
  Widget build(BuildContext context) {

    final color = Colors.grey.withOpacity(0.5);

    final timeText = Text(
      'hh:mm aa',
      style: TextStyle(fontSize: 10.0),
    );

    final spaceText = Text(
      "prueba"
    );

    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(isOwned ? 16 : 0),
      topRight: Radius.circular(isOwned ? 0 : 16),
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    );

    final boxDecoration = BoxDecoration(
      color: Colors.red,
      borderRadius: borderRadius,
    );

    final boxConstraints = BoxConstraints(
      minWidth: 128,
      maxWidth: 276,
    );

    final bubble = Container(
      child: spaceText,
      padding: EdgeInsets.all(12.0),
      decoration: boxDecoration,
      constraints: boxConstraints,
    );

    final avatarDecoration = BoxDecoration(
      color: Colors.grey,
      shape: BoxShape.circle,
    );

    final avatar = Container(
      width: 24,
      height: 24,
      margin: EdgeInsets.only(right: 8.0),
      decoration: avatarDecoration,
    );

    final content = Column(
      crossAxisAlignment: isOwned
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [timeText, SizedBox(height: 8), bubble],
    );

    final container = Row(
      mainAxisAlignment: isOwned
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [if (!isOwned) avatar, content],
    );

    final containerWithConstraints = Container(
      constraints: BoxConstraints(minWidth: 128, maxWidth: 276),
      child: container,
    );

    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: color.withOpacity(0.8),
      child: containerWithConstraints,
    );

  }

}
