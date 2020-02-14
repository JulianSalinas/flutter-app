import 'package:flutter/cupertino.dart';

class Preview {

  final String key;
  final String title;
  final String description;
  final String image;
  final String url;
  final String thumbnail;

  Preview({
    @required this.key,
    this.title,
    this.description,
    this.image,
    this.url,
    this.thumbnail
  });

  factory Preview.fromMap(Map snapshot) {
    return Preview(
      key: 'preview-${snapshot['key']}',
      title: snapshot['title'],
      description: snapshot['description'],
      image: snapshot['image'],
      url: snapshot['url'],
      thumbnail: snapshot['thumbnail'],
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Preview && key == other.key;
  }

  @override
  int get hashCode => key.hashCode;

}