import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letsattend/models/event.dart';
import 'package:letsattend/services/firestore_service.dart';

class EventsService extends FirestoreService<Event> {

  final String source = 'meetings/edepa6/schedule';

  @override
  Event fromFirestore(DocumentSnapshot snapshot) {
    final event = Event.fromFirestore(snapshot);
    event.speakers = snapshot['speakers'] ?? [];
    return event;
  }

  @override
  Stream<List<Event>> createStream() {
    return super
        .db
        .collection(source)
        .orderBy('start')
        .snapshots()
        .map((snapshot) => fromSnapshot(snapshot).toList());
  }

}
