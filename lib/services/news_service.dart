import 'package:firebase_database/firebase_database.dart';

import 'package:letsattend/models/post.dart';
import 'package:letsattend/models/preview.dart';
import 'package:letsattend/services/firebase_service.dart';

class NewsService extends FirebaseService<Post> {

  NewsService(): super('edepa6/news');

  Preview getPreview(dynamic data){
    return data == null ? null : Preview(
      url: data['url'],
      title: data['header'],
      thumbnail: data['thumbnail'],
      description: data['description'],
    );
  }

  @override
  Future<Post> castSnapshot(DataSnapshot snapshot) async {

    final data = snapshot.value;

    return Post(
      key: snapshot.key,
      title: data['title'],
      description: data['content'],
      preview: getPreview(data['preview']),
      timestamp: castMilliseconds(data['time']),
    );
  }

}
