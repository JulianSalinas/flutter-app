import 'package:flutter/material.dart';
import 'package:letsattend/controllers/theme_controller.dart';
import 'package:letsattend/widgets/event/item_point.dart';
import 'package:provider/provider.dart';

class ItemLine extends StatelessWidget {

  final Color color;
  final bool isFirst;
  final bool isLast;
  final bool isOdd;

  const ItemLine({
    Key key,
    @required this.color,
    this.isFirst = false,
    this.isLast = false,
    this.isOdd = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<ThemeController>(context);
    final lineColor = scheme.nightMode ? Colors.white : Colors.black;

    final topLine = Container(
      width: 2,
      height: 15,
      color: isFirst ? Colors.transparent : lineColor,
    );

    final bottomLine = Container(
      width: 2,
      color: isLast ? Colors.transparent : lineColor,
    );

    final bottomLineContent = Opacity(
        opacity: 0.15,
        child: bottomLine,
    );

    final content = Column(
      children: <Widget>[
        Opacity(opacity: 0.15, child: topLine),
        NestedPoint(color: isOdd ? color : lineColor, isOdd: isOdd),
        Expanded(child: bottomLineContent),
      ],
    );

    return Container(width: 44, child: content);
  }
}
