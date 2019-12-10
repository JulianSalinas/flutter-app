import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:letsattend/colors/flat_ui.dart';
import 'package:letsattend/colors/ui_colors.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/providers/scheme.dart';
import 'package:provider/provider.dart';
import 'item_decoration.dart';

/// A simple colored screen with a centered text
class Item extends StatelessWidget {

  final isLast;
  final isFirst;
  final isEven;

  final Event event = Event(
    code: 'C01',
    type: 'TALLER',
    location: 'Centro de las Artes',
    start: DateTime.now(),
    end: DateTime.now(),
    title: 'Competencias profesionales de profesores de matemática (prospectiva): aproximaciones cognitivas versus situadas',
  );

  Item({
    this.isFirst = false,
    this.isLast = false,
    this.isEven = false,
  });

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<Scheme>(context);

    final decoration = ItemDecoration(
      isFirst: isFirst,
      isLast: isLast,
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
      style: TextStyle(fontSize: 16),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );

    final itemLocation = Opacity(
      opacity: 0.6,
      child: Row(
        children: <Widget>[
          Icon(
            Entypo.location_pin,
            size: 16,
          ),
          SizedBox(
            width: 4,
          ),
          Text(event.location)
        ],
      ),
    );

    final itemReadMore = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Leer más',
            style: TextStyle(color: FlatUI.peterRiver),
          ),
          Icon(
            AntDesign.star,
            color: FlatUI.sunflower,
          ),
        ],
      ),
    );

    final content = Container(
      padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
      child: Column(
        children: <Widget>[
          itemTop,
          SizedBox(
            height: 12,
          ),
          itemTitle,
          SizedBox(
            height: 8,
          ),
          itemLocation,
          SizedBox(
            height: 12,
          ),
          itemReadMore
        ],
      ),
    );

    return Container(
      height: 164,
      color: isEven
          ? Colors.transparent
          : scheme.nightMode ? UIColors.nightOverlay : UIColors.lightOverlay,
      child: Row(children: <Widget>[decoration, Expanded(child: content)]),
    );
  }
}
