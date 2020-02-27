import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/services/synched/firebase_service.dart';

class SpeakersService extends FirebaseService<Speaker> {

  @override
  String get path => 'edepa6/people';

  @override
  String get orderBy => 'completeName';

  @override
  Future<Speaker> fromFirebase(DataSnapshot snapshot) async {
    snapshot.value['key'] = snapshot.key;
    return Speaker.fromMap(snapshot.value);
  }

}
