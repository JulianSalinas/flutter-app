import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/services/firebase_service.dart';
import 'package:letsattend/shared/utils.dart';

class SpeakersService extends FirebaseService<Speaker> {

  SpeakersService() : super('edepa6/people', orderBy: 'completeName');

  Future<Speaker> getSpeaker(String key) async {
    final snapshot =
        await database.child('edepa6').child('people').child(key).once();

    return parse(snapshot);
  }

  @override
  Future<Speaker> parse(DataSnapshot snapshot) async {
    final data = snapshot.value;

    final about = SharedUtils.cleanText(data['about']);
    final university = SharedUtils.cleanText(data['university']);

    final inferredUniversity =
        university == null && about != null && about.length <= 50
            ? about
            : null;

    return Speaker(
      key: snapshot.key,
      name: SharedUtils.formatName(data['completeName']),
      about: about,
      country: SharedUtils.cleanText(data['personalTitle']),
      university: university ?? inferredUniversity,
      eventKeys: data['events'],
    );
  }
}
