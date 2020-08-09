import 'package:firebase_database/firebase_database.dart';

import 'package:letsattend/models/post.dart';
import 'package:letsattend/models/preview.dart';
import 'package:letsattend/shared/utils.dart';
import 'package:letsattend/services/firebase_service.dart';

class NewsService extends FirebaseService<Post> {

  NewsService(): super('edepa6/news');

  Preview getPreview(dynamic data){
    return Preview(
      url: data['url'],
      title: data['header'],
      thumbnail: data['thumbnail'],
      description: data['description'],
    );
  }

  @override
  Future<Post> parse(DataSnapshot snapshot) async {

    final data = snapshot.value;

    final preview = data['preview'] != null
        ? getPreview(data['preview'])
        : null;

    return Post(
      key: snapshot.key,
      preview: preview,
      title: SharedUtils.cleanText(data['title']),
      description: SharedUtils.cleanText(data['content']),
      timestamp: SharedUtils.castMilliseconds(data['time']),
    );
  }

}
