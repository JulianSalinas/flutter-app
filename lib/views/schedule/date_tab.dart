import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class DateTab extends StatelessWidget {

  static const double WIDTH = 148;

  final DateTime dateTime;
  final String dateString;

  DateTab({
    this.dateTime,
    this.dateString,
  });

  @override
  Widget build(BuildContext context) {

    final content = Align(
      child: Text(dateString ?? Jiffy(dateTime).format('EEEE do').toUpperCase()),
      alignment: Alignment.center,
    );

    final container = Container(
      child: content,
      width: DateTab.WIDTH,
    );

    return Tab(child: container);

  }

}
