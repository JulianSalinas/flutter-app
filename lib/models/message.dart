import 'package:flutter/material.dart';

class Message {

  final String key;

  final int timestamp;
  final String content;
  final String senderId;
  final String senderName;
  final bool delivered;

  Message({
    @required this.key,
    @required this.timestamp,
    @required this.content,
    @required this.senderId,
    @required this.senderName,
    this.delivered = false,
  });

  factory Message.fromMap(Map snapshot) {
    return Message(
      key: snapshot['key'],
      timestamp: snapshot['time'],
      content: snapshot['content'],
      senderId: snapshot['userid'],
      senderName: snapshot['username'],
      delivered: snapshot['delivered'],
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Message && key == other.key;
  }

  @override
  int get hashCode => key.hashCode;

}
