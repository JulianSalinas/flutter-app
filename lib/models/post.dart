import 'package:letsattend/models/preview.dart';

class Post {

  final String key;
  final String title;
  final String description;

  final Preview preview;
  final DateTime timestamp;

  Post({
    this.key,
    this.title,
    this.description,
    this.preview,
    this.timestamp,
  });

  @override
  int get hashCode => key.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Post && key == other.key;
  }

  @override
  String toString() {
    return 'Post{ key: $key, title: $title, preview: $preview }';
  }

}
