import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letsattend/models/post.dart';
import 'package:letsattend/services/firestore_service.dart';

class NewsService extends FirestoreService<Post> {

  NewsService() : super(
    key: 'time',
    source: 'meetings/edepa6/news',
  );

  @override
  Future<Post> fromFirestore(DocumentSnapshot snapshot) async {
    return Post.fromFirestore(snapshot);
  }

}
