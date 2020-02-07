import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {

  final String key;

  final String time;
  final String content;
  final String senderId;
  final String senderName;
  final bool delivered;

  Message({
    @required this.key,
    @required this.time,
    @required this.content,
    @required this.senderId,
    @required this.senderName,
    this.delivered = false,
  });

  factory Message.fromMap(String key, Map snapshot) => Message(
        key: key,
        time: snapshot['time'],
        content: snapshot['content'],
        senderId: snapshot['userid'],
        senderName: snapshot['username'],
        delivered: snapshot['delivered'],
      );

  factory Message.fromFirebase(DocumentSnapshot snapshot) {
    return Message.fromMap(snapshot.documentID, snapshot.data);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message && runtimeType == other.runtimeType && key == other.key;

  @override
  int get hashCode => key.hashCode;
}
