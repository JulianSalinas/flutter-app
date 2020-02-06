import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/models/speaker.dart';
import 'package:letsattend/services/firestore_service.dart';

class EventsService extends FirestoreService<Event> {

  EventsService() : super(
    key: 'start',
    source: 'meetings/edepa6/schedule',
  );

  Speaker mapPartialSpeaker(dynamic preview) {
    Map snapshot = Map();
    snapshot['name'] = preview['name'];
    snapshot['reference'] = preview['reference'];
    return Speaker.partial(preview['reference'].documentID, snapshot);
  }

  @override
  Future<Event> fromFirestore(DocumentSnapshot snapshot) async {
    final event = Event.fromFirestore(snapshot);
    List<dynamic> partialSpeakers = snapshot['speakers'];
    event.speakers = partialSpeakers.map(mapPartialSpeaker).toList();
    return event;
  }

}
