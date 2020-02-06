import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory Preview.fromMap(String key, Map snapshot) => Preview(
    key: 'preview-$key',
    title: snapshot['title'],
    description: snapshot['description'],
    image: snapshot['image'],
    url: snapshot['url'],
    thumbnail: snapshot['thumbnail'],
  );

  factory Preview.fromFirestore(DocumentSnapshot snapshot) {
    return Preview.fromMap(snapshot.documentID, snapshot.data);
  }

}