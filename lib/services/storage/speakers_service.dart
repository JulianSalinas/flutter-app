import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/services/storage/firestore_service.dart';

class SpeakersService extends FirestoreService<Speaker> {

  SpeakersService() : super(
    key: 'name',
    source: 'meetings/edepa6/speakers',
  );

  @override
  Future<Speaker> fromFirestore(DocumentSnapshot snapshot) async {
    return Speaker.fromFirestore(snapshot);
  }

}
