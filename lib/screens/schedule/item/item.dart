import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/providers/scheme.dart';
import 'package:provider/provider.dart';
import 'item_decoration.dart';
import 'item_people.dart';


class Item extends StatelessWidget {

  final bool isLast;
  final bool isFirst;
  final bool isOdd;
  final Event event;

  Item({
    this.isFirst = false,
    this.isLast = false,
    this.isOdd = false,
    @required this.event
  });

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<Scheme>(context);

    final decoration = ItemDecoration(
      isFirst: isFirst,
      isLast: isLast,
      isOdd: isOdd,
      color: event.getColor(),
    );

    final itemType = Text(
      '${event.code}. ${event.type} ',
      style: TextStyle(fontSize: 16, color: event.getColor()),
    );

    final itemDate = Opacity(
      opacity: 0.6,
      child: Text('9:40 AM - 12:10 PM', style: TextStyle(fontSize: 12)),
    );

    final itemTop = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[itemType, itemDate],
    );

    final itemTitle = Text(
      event.title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );

    final itemLocation = Row(
      children: <Widget>[
        Icon(Entypo.location_pin, size: 16),
        SizedBox(width: 4),
        Text(event.location),
      ],
    );

    final itemPeople = ItemPeople(
      people: event.people
    );

    final itemFavorite = Icon(
      AntDesign.star,
      color: FlatUI.sunflower,
    );

    final itemBottom = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[itemPeople, itemFavorite],
      ),
    );

    final itemContent = Column(
      children: <Widget>[
        itemTop,
        SizedBox(height: 12),
        itemTitle,
        SizedBox(height: 8),
        itemLocation,
        SizedBox(height: 12),
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

    return Container(
      height: 164,
      child: stackContainer,
    );

  }
}

