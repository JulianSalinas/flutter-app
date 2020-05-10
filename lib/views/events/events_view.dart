import 'package:flutter/material.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/views/events/event_widget/event_widget.dart';

class EventsView extends StatelessWidget {

  final List<Event> events;
  final Function(Event) toggleFavorite;

  EventsView({Key key,
    @required this.events,
    @required this.toggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: events.length,
      padding: EdgeInsets.only(top: 4),
      itemBuilder: (context, index) => EventWidget(
        event: events.elementAt(index),
        isFirst: index == 0,
        isLast: index == events.length - 1,
        isOdd: index.isEven,
        toggleFavorite: toggleFavorite,
      ),
    );

  }

}