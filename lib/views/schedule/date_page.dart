import 'package:flutter/material.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/widgets/event/item.dart';

class DatePage extends StatefulWidget {

  final DateTime date;
  DatePage({@required this.date});

  @override
  DatePageState createState() => DatePageState();
}

class DatePageState extends State<DatePage> {

  List<Event> events = <Event>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) => Item(
        event: events.elementAt(index),
        isFirst: index == 0,
        isLast: index == events.length - 1,
        isOdd: index.isEven,
        onFavoriteChanged: onFavoriteChange,
      ),
    );

  }


  onFavoriteChange(Event event) {
    setState(() {
      event.isFavorite = !event.isFavorite;
    });
  }

}