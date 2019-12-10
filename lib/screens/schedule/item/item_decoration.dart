import 'package:flutter/material.dart';
import 'package:letsattend/providers/scheme.dart';
import 'package:letsattend/shared/nested_point.dart';
import 'package:provider/provider.dart';

class ItemDecoration extends StatelessWidget {

  final Color color;
  final bool isFirst;
  final bool isLast;

  const ItemDecoration({
    Key key,
    @required this.color,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final scheme = Provider.of<Scheme>(context);
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
        NestedPoint(color: color),
        Expanded(child: bottomLineContent),
      ],
    );

    return Container(width: 44, child: content);
  }
}
