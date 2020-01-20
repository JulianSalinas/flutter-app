import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letsattend/services/database_service.dart';

abstract class FirestoreService<T> extends DatabaseService {

  Firestore get db => Firestore.instance;

  T fromFirestore(DocumentSnapshot snapshot);

  Iterable<T> fromSnapshot(QuerySnapshot snapshot){
    String from = snapshot.metadata.isFromCache ? 'CACHE' : 'NETWORK';
    print('${T.toString()}s: Loaded from $from');
    return snapshot.documents.map(fromFirestore);
  }

}
