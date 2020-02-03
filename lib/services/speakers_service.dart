import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/services/firestore_service.dart';

class SpeakersService extends FirestoreService<Speaker> {

  final String source = 'meetings/edepa6/speakers';

  @override
  Future<Speaker> fromFirestore(DocumentSnapshot snapshot) async {
    return Speaker.fromFirestore(snapshot);
  }

  @override
  Stream<List<Speaker>> createStream() {
    return super
        .db
        .collection(source)
        .orderBy('name', descending: false)
        .snapshots()
        .asyncMap((snapshot) async => await fromSnapshot(snapshot));
  }

}
