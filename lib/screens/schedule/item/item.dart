import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/providers/scheme.dart';
import 'package:letsattend/screens/schedule/item/item_favorite.dart';
import 'package:provider/provider.dart';
import 'item_decoration.dart';
import 'item_people.dart';


class Item extends StatelessWidget {

  final Event event;

  final bool isLast;
  final bool isFirst;
  final bool isOdd;

  final Function onFavoriteChanged;

  Item({
    @required this.event,
    this.isFirst = false,
    this.isLast = false,
    this.isOdd = false,
    this.onFavoriteChanged
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
      style: TextStyle(color: event.getColor()),
    );

    final itemDate = Opacity(
      opacity: 0.6,
      child: Text('9:40 AM - 12:10 PM', style: TextStyle(fontSize: 10)),
    );

    final itemTop = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[itemType, itemDate],
    );

    final itemTitle = Text(
      event.title,
      style: TextStyle(fontWeight: FontWeight.bold),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );

    final itemLocation = Row(
      children: <Widget>[
        Icon(Entypo.location_pin, size: 14),
        SizedBox(width: 4),
        Text(event.location, style: TextStyle(fontSize: 12)),
      ],
    );

    final itemPeople = ItemPeople(
      people: event.people
    );

    final itemFavorite = Favorite(
      isFavorite: event.isFavorite,
      onPressed: () => onFavoriteChanged(event)
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

    return Container(
      height: 154,
      child: stackContainer,
    );

  }
}

