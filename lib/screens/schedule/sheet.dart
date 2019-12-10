import 'package:flutter/material.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/screen.dart';
import 'package:letsattend/screens/schedule/item/item.dart';

class Sheet extends StatefulWidget {

  final DateTime date;
  Sheet({@required this.date});

  @override
  SheetState createState() => SheetState();
}

class SheetState extends State<Sheet> {

  final events = <Event>[];

  @override
  void initState() {
    super.initState();
    Event e1 = Event();
    events.addAll([e1, e1, e1]);
  }

  @override
  Widget build(BuildContext context) {

    final listView = ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) => Item(
        isFirst: index == 0,
        isLast: index == events.length - 1,
        isEven: index.isEven,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Screen(
          child: listView,
        ),
      ),
    );
  }

}