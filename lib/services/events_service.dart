import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/services/firestore_service.dart';
import 'package:letsattend/views/speakers/speakers_view.dart';

class EventsService extends FirestoreService<Event> {

  final String source = 'meetings/edepa6/schedule';

//    await Future.forEach(snapshot['speakers'], (reference) async {
//      DocumentSnapshot snapshot = await reference.get();
//      event.speakers.add(Speaker.fromFirestore(snapshot));
//    });

  Speaker mapSpeaker(dynamic preview) {
    Map snapshot = Map();
    snapshot['name'] = preview['name'];
    snapshot['reference'] = preview['reference'];
    return Speaker.partial(preview['reference'].documentID, snapshot);
  }

  @override
  Future<Event> fromFirestore(DocumentSnapshot snapshot) async {
    final event = Event.fromFirestore(snapshot);
    List<dynamic> previewSpeakers = snapshot['speakers'];
    event.speakers = previewSpeakers.map(mapSpeaker).toList();
    return event;
  }

  @override
  Stream<List<Event>> createStream() {
    return super
        .db
        .collection(source)
        .orderBy('start')
        .snapshots()
        .asyncMap((snapshot) async => await fromSnapshot(snapshot));
  }

}
