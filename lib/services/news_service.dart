import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/services/synched/firebase_service.dart';

class NewsService extends FirebaseService<Post> {

  NewsService(): super('edepa6/news', orderBy: 'timestamp');

  @override
  Future<Post> castSnapshot(DataSnapshot snapshot) async {
    snapshot.value['key'] = snapshot.key;
    return Post.fromMap(snapshot.value);
  }

}
