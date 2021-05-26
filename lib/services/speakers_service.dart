import 'package:firebase_database/firebase_database.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/services/firebase_service.dart';
import 'package:letsattend/shared/utils.dart';

class SpeakersService extends FirebaseService<Speaker> {

  SpeakersService() : super('edepa6/people', orderBy: 'completeName');

  Future<Speaker?> getSpeaker(String key) async {

    final snapshot = await database
        .child('edepa6')
        .child('people')
        .child(key).once();

    return parse(snapshot);

  }

  @override
  Future<Speaker?> parse(DataSnapshot snapshot) async {

    if (snapshot.key == null || snapshot.value == null) return null;

    final data = snapshot.value;
    final name = SharedUtils.formatName(data['completeName']);
    final about = SharedUtils.cleanText(data['about']);
    final university = SharedUtils.cleanText(data['university']);
    final country = SharedUtils.cleanText(data['personalTitle']);

    final isAboutAUniversity = about != null && about.length <= 50;
    final inferredUniversity = isAboutAUniversity ? about : null;

    return Speaker(
      key: snapshot.key!,
      name: name ?? "unknown",
      about: about,
      country: country,
      university: university ?? inferredUniversity,
    );

  }

}
