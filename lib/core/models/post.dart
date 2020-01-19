import 'package:letsattend/core/models/preview.dart';

class Post {

  String title;
  String description;
  DateTime timestamp;

  Preview preview;

  Post({
    this.title,
    this.description,
    this.preview,
    this.timestamp
  });

  Post.empty();

}