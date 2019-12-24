import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/screens/sample.dart';
import 'package:letsattend/screens/schedule/date_page.dart';

class Schedule extends StatefulWidget {
  @override
  ScheduleState createState() => ScheduleState();
}

class ScheduleState extends State<Schedule> {
  final pageCtrl = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    final pageView = PageView(
      controller: pageCtrl,
      pageSnapping: true,
      children: <Widget>[
        DatePage(date: DateTime.now()),
        Sample(color: FlatUI.peterRiver, text: 'Page 2'),
        Sample(color: FlatUI.pomegranate, text: 'Page 3'),
      ],
    );

    final control = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          child: Text('Atrás'),
          onPressed: () => pageCtrl.previousPage(
            duration: Duration(milliseconds: 250),
            curve: Curves.easeOut,
          ),
        ),
        FlatButton(
          child: Text('Siguiente'),
          onPressed: () => pageCtrl.nextPage(
            duration: Duration(milliseconds: 250),
            curve: Curves.easeIn,
          ),
        ),
      ],
    );

    final content = Column(
      children: <Widget>[
        Expanded(
          child: pageView,
        ),
        Container(
          height: 48,
          child: control,
        )
      ],
    );

    final container = Container(
      child: content,
    );

    return Scaffold(body: SafeArea(child: container));
  }
}
