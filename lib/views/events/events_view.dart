import 'package:flutter/material.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/views/events/event_widget/event_widget.dart';

class EventsView extends StatefulWidget {

  final List<Event> events;
  EventsView({Key key, @required this.events}) : super(key: key);

  @override
  EventsViewState createState() => EventsViewState();
}

class EventsViewState extends State<EventsView> {

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: widget.events.length,
      padding: EdgeInsets.only(top: 4),
      itemBuilder: (context, index) => EventWidget(
        event: widget.events.elementAt(index),
        isFirst: index == 0,
        isLast: index == widget.events.length - 1,
        isOdd: index.isEven,
        onFavoriteChanged: onFavoriteChange,
      ),
    );

  }


  onFavoriteChange(Event event) {
//    setState(() {
//      event.isFavorite = !event.isFavorite;
//    });
  }

}