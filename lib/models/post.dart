import 'package:letsattend/models/preview.dart';

class Post {

  final String key;
  final DateTime timestamp;

  final String? title;
  final String? description;
  final Preview? preview;

  Post({
    required this.key,
    required this.timestamp,
    this.title,
    this.description,
    this.preview,
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
