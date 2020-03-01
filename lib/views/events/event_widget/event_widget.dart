import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/blocs/settings_bloc.dart';
import 'package:letsattend/views/detail/detail.dart';
import 'package:letsattend/views/events/event_widget/event_favorite.dart';
import 'package:provider/provider.dart';
import 'event_leading.dart';
import 'event_speakers.dart';


class EventWidget extends StatelessWidget {

  static Map<String, Color> colors = {
    'CONFERENCIA': Color(0xff21bf73),
    'TALLER': Color(0xfff5587b),
    'PONENCIA': Color(0xffff8a5c),
    'FERIA_EDEPA': Color(0xff9399ff),
  };

  final Event event;

  final bool isLast;
  final bool isFirst;
  final bool isOdd;

  final Function(Event) toggleFavorite;

  EventWidget({
    @required this.event,
    this.isFirst = false,
    this.isLast = false,
    this.isOdd = false,
    this.toggleFavorite
  });

  openDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Detail(event: event)),
    );
  }

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<SettingsBloc>(context);

    final decoration = ItemLine(
      isFirst: isFirst,
      isLast: isLast,
      isOdd: isOdd,
      color: Colors.red,
    );

    final itemType = Text(
      '${event.code}. ${event.type} ',
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold
      ),
    );

    final itemDate = Opacity(
      opacity: 0.6,
      child: Hero(
        tag: 'event-date-${event.key}',
        child: Text(
          '9:40 AM - 12:10 PM',
          style: TextStyle(fontSize: 10),
        ),
      ),
    );

    final itemTop = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[itemType, itemDate],
    );

    final itemTitle = Hero(
      tag: 'event-title-${event.key}',
      child: Text(
        event.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    final itemLocation = Row(
      children: <Widget>[
        Icon(Entypo.location_pin, size: 14),
        SizedBox(width: 4),
        Text(event.location, style: TextStyle(fontSize: 12)),
      ],
    );

    final itemPeople =  event.speakers.length > 0 ? ItemPeople(
      speakers: event.speakers
    ): Row(
      children: <Widget>[
        SizedBox.shrink(),
      ],
    );

    final itemFavorite = Favorite(
      tag: 'event-favorite-${event.key}',
      isFavorite: event.isFavorite,
      onPressed: () => toggleFavorite(event)
    );

    final itemBottom = Container(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          itemPeople,
          Positioned(right: 0, top: -16, child: itemFavorite),
        ],
      ),
    );

    final itemContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        itemTop,
        SizedBox(height: 12),
        itemTitle,
        SizedBox(height: 8),
        itemLocation,
        SizedBox(height: 8),
        itemBottom
      ],
    );

    final itemContainer = Container(
      padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
      child: itemContent,
    );

    final stackContrast = scheme.nightMode ? Colors.white : Colors.black;

    final stackBackground = Opacity(
      opacity: isOdd ? 1 : 0.04,
      child: Container(color: isOdd ? Colors.transparent : stackContrast),
    );

    final stackContainer = Stack(
      children: <Widget>[
        stackBackground,
        Row(children: <Widget>[decoration, Expanded(child: itemContainer)])
      ],
    );

    return Container(height: 154, child: stackContainer);

  }
}

