import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/services/synched/firebase_service.dart';

class SpeakersService extends FirebaseService<Speaker> {

  SpeakersService(): super('edepa6/people', orderBy: 'completeName');

  @override
  Future<Speaker> castSnapshot(DataSnapshot snapshot) async {
    return _castSnapshot(snapshot);
  }

  Future<Speaker> getSpeaker(String key) async {

    final snapshot = await database
        .child('edepa6')
        .child('people')
        .child(key).once();

    return _castSnapshot(snapshot);
  }

  Speaker _castSnapshot(DataSnapshot snapshot){

    final data = getData(snapshot);

    return Speaker(
      key: data['key'],
      name: data['completeName'],
      about: data['about'],
      country: data['country'],
      university: data['university'],
    );
  }

}
