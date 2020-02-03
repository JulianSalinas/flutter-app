import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:letsattend/models/event.dart';
import 'package:letsattend/widgets/clock/clock.dart';
import 'package:letsattend/views/events/event_widget/event_favorite.dart';
import 'package:letsattend/widgets/hero_text.dart';


/// A simple colored screen with a centered text
class DetailHeader extends StatelessWidget {

  final Event event;

  DetailHeader({ @required this.event });

  @override
  Widget build(BuildContext context) {

    final type = Text(
      '${event.code}. ${event.type}',
      style: TextStyle(color: Colors.white),
    );

    final label = Container(
      child: type,
      color: event.getColor(),
      padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
    );

    final date = HeroText(
      '9:40 AM - 12:10 PM',
      tag: 'event-date-${event.key}',
      style: Typography.englishLike2018.headline.copyWith(color: Colors.white),
    );

    final location = Row(
      children: <Widget>[
        Icon(Entypo.location_pin, size: 14, color: Colors.white),
        SizedBox(width: 4),
        Text(event.location, style: TextStyle(fontSize: 12, color: Colors.white)),
      ],
    );

    final favorite = Favorite(
      tag: 'event-favorite-${event.key}',
      isFavorite: event.isFavorite,
      onPressed: () => print('TODO: Get data')
    );

    final bottom = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Expanded(child: date), favorite],
    );

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [label, SizedBox(height: 8), location, bottom],
    );

    final information = Container(
      child: content,
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    );

    final container = Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: information,
    );

    final background = Image(
      fit: BoxFit.cover,
      image: AssetImage(event.getImage()),
    );

    final line = Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(height: 0, color: event.getColor()), /// +1 to active
    );

    final clock = Positioned(
      left: 0,
      top: 80,
      right: 0,
      bottom: 120,
      child: Clock(event.start.toDate()),
    );

    final filter = Container(color: Colors.black38);

    return Stack(
      fit: StackFit.expand,
      children: [background, filter, container, line, clock],
    );

  }

}
