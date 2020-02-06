import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:letsattend/models/preview.dart';

class Post {

  final String key;
  final Timestamp time;

  final String title;
  final String description;
  final Preview preview;

  Post({
    @required this.key,
    @required this.time,
    this.title,
    this.description,
    this.preview,
  });

  factory Post.fromMap(String key, Map snapshot) => Post(
    key: key,
    time: snapshot['time'],
    title: snapshot['title'],
    description: snapshot['description'],
    preview: snapshot['preview'] == null
        ? null
        : Preview.fromMap(key, snapshot['preview']),
  );

  factory Post.fromFirestore(DocumentSnapshot snapshot) {
    return Post.fromMap(snapshot.documentID, snapshot.data);
  }

}
