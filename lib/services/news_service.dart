import 'package:firebase_database/firebase_database.dart';

import 'package:letsattend/models/post.dart';
import 'package:letsattend/models/preview.dart';
import 'package:letsattend/shared/utils.dart';
import 'package:letsattend/services/firebase_service.dart';

class NewsService extends FirebaseService<Post> {

  NewsService() : super('edepa6/news');

  Preview? getPreview(dynamic data) {

    if (data == null) return null;

    return Preview(
      url: data['url'],
      title: data['header'],
      thumbnail: data['thumbnail'],
      description: data['description'],
    );

  }

  @override
  Future<Post?> parse(DataSnapshot snapshot) async {

    if (snapshot.key == null || snapshot.value == null) return null;

    final data = snapshot.value;

    return Post(
      key: snapshot.key!,
      title: SharedUtils.cleanText(data['title']),
      description: SharedUtils.cleanText(data['content']),
      timestamp: SharedUtils.castMilliseconds(data['time']),
      preview: getPreview(data['preview']),
    );

  }

}
