import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:letsattend/models/filter.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/services/firestore_service.dart';

class SpeakersService extends FirestoreService<Speaker> {

  final String source = 'meetings/edepa6/speakers';

  @override
  Speaker fromFirestore(DocumentSnapshot snapshot) {
    return Speaker.fromFirestore(snapshot);
  }

  @override
  Stream<List<Speaker>> getSpeakersStream(Filter filter) {
    return super
        .db
        .collection(source)
        .orderBy('name', descending: !filter.asc)
        .snapshots()
        .map((snapshot) => fromSnapshot(snapshot).where(filter.apply).toList());
  }

}
