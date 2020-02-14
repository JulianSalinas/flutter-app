import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letsattend/models/message.dart';

class BubbleWidget extends StatelessWidget {

  final Message message;

  BubbleWidget({
    Key key,
    @required this.message,
  }) : super(key: key ?? Key(message.key));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(message.timestamp.toString()),
        Text(message.senderName),
        Text(message.content),
      ],
    );
  }

}
