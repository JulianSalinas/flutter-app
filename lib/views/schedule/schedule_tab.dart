import 'package:flutter/material.dart';

class ScheduleTab extends StatelessWidget {

  static const double WIDTH = 148;

  final String text;

  ScheduleTab(this.text);

  @override
  Widget build(BuildContext context) {

    final content = Align(
      child: Text(text),
      alignment: Alignment.center,
    );

    final container = Container(
      child: content,
      width: ScheduleTab.WIDTH,
    );

    return Tab(child: container);

  }

}
