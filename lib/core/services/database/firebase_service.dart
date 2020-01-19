import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letsattend/core/models/speaker.dart';
import 'package:letsattend/core/services/database/database_service.dart';

class FirebaseService extends DatabaseService {

  final Firestore _db = Firestore.instance;

  @override
  Stream<List<Speaker>> get speakers {
    final from = 'meetings/edepa6/speakers';
    final map = (doc) => Speaker.fromFirestore(doc);
    return _db
        .collection(from)
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.documents.map(map).toList());
  }


}
