import 'package:flutter/material.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/views/events/event_widget/event_widget.dart';
import 'package:letsattend/widgets/common/empty_view.dart';

class EventsView extends StatelessWidget {

  final List<Event> events;
  final Function(Event) toggleFavorite;

  EventsView({Key key,
    @required this.events,
    @required this.toggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (events == null || events.length <= 0)
      return EmptyView('Vacío', 'Esta persona no tiene eventos asociados');

    return ListView.builder(
      itemCount: events.length,
      padding: EdgeInsets.only(top: 0),
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