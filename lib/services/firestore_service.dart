import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letsattend/services/database_service.dart';

abstract class FirestoreService<T> extends DatabaseService {

  Firestore get db => Firestore.instance;

  Future<T> fromFirestore(DocumentSnapshot snapshot);

  Future<Iterable<T>> fromSnapshot(QuerySnapshot snapshot) async {
    String from = snapshot.metadata.isFromCache ? 'CACHE' : 'NETWORK';
    print('${T.toString()}s: Loaded from $from');
    return Future.wait(snapshot.documents.map(fromFirestore));
  }

}
