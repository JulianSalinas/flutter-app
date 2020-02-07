import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:letsattend/services/stream_service.dart';

abstract class FirestoreService<T> extends StreamService {

  final String key;
  final String source;
  final bool descending;

  FirestoreService({
    @required this.key,
    @required this.source,
    this.descending,
  });

  Future<T> fromFirestore(DocumentSnapshot snapshot);

  Future<Iterable<T>> fromSnapshot(QuerySnapshot snapshot) async {
    String from = snapshot.metadata.isFromCache ? 'CACHE' : 'NETWORK';
    print('${T.toString()}s: Loaded from $from');
    return Future.wait(snapshot.documents.map(fromFirestore));
  }

  @override
  Stream<List<T>> get stream {
    return Firestore.instance
        .collection(source)
        .orderBy(key, descending: descending)
        .snapshots()
        .asyncMap((snapshot) async => await fromSnapshot(snapshot));
  }

}
