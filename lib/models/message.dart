import 'package:flutter/material.dart';
import 'package:letsattend/models/user.dart';

class Message {

  String key;

  final String content;
  final User sender;
  final DateTime timestamp;
  final bool delivered;

  Message({
    @required this.key,
    @required this.sender,
    @required this.content,
    @required this.timestamp,
    this.delivered = false,
  });

  Message.send({
    @required this.sender,
    @required this.content,
    @required this.timestamp,
    this.delivered = false,
  });

  toJson() {
    return {
      'time': DateTime.now().millisecondsSinceEpoch,
      'content': content,
      'delivered': delivered,
      'userid': sender.id,
      'username': sender.name,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Message && key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}
