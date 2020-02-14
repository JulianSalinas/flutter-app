import 'package:flutter/foundation.dart';
import 'package:letsattend/models/preview.dart';

class Post {

  final String key;
  final int timestamp;

  final String title;
  final String description;
  final Preview preview;

  Post({
    @required this.key,
    @required this.timestamp,
    this.title,
    this.description,
    this.preview,
  });

  factory Post.fromMap(Map snapshot) {
    return Post(
      key: snapshot['key'],
      timestamp: snapshot['time'],
      title: snapshot['title'],
      description: snapshot['description'],
      preview: snapshot['preview'] == null
          ? null
          : Preview.fromMap(snapshot['preview']),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Post && key == other.key;
  }

  @override
  int get hashCode => key.hashCode;

}
