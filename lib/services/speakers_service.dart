import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/services/firebase_service.dart';

class SpeakersService extends FirebaseService<Speaker> {

  SpeakersService(): super('edepa6/people', orderBy: 'completeName');

  Future<Speaker> getSpeaker(String key) async {

    final snapshot = await database
        .child('edepa6')
        .child('people')
        .child(key).once();

    return parse(snapshot);
  }

  @override
  Future<Speaker> parse(DataSnapshot snapshot) async {

    final data = snapshot.value;

    return Speaker(
      key: snapshot.key,
      name: data['completeName'],
      about: data['about'],
      country: data['personalTitle'],
      university: data['university'],
      eventKeys: data['events'],
    );

  }

}
